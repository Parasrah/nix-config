{ pkgs, config, lib, ... }:
let
  uid =
    config.ids.uids.mopidy;

  gid =
    config.ids.gids.mopidy;

  dataDir =
    "/var/lib/mopidy";

  extensionPackages = with pkgs.unstable; [
    mopidy-iris
    mopidy-spotify
    # TODO: seems broken on 20.03 and unstable
    # complains about missing "mopidy.local"
    # mopidy-local-sqlite
    mopidy-mopify
    mopidy-mpd
  ];

  mopidyEnv = with pkgs.unstable; buildEnv {
    name = "mopidy-with-extensions-${mopidy.version}";
    paths = lib.closePropagation extensionPackages;
    pathsToLink = [ "/${mopidyPackages.python.sitePackages}" ];
    buildInputs = [ makeWrapper ];
    postBuild = ''
      makeWrapper ${mopidy}/bin/mopidy $out/bin/mopidy \
        --prefix PYTHONPATH : $out/${mopidyPackages.python.sitePackages}
    '';
  };

  mopidyConf = pkgs.writeText "mopidy.conf" ''
    [core]

    [logging]
    color = true

    [audio]
    mixer = software
    output = pulsesink server=127.0.0.1
    # buffer_time =

    [file]

    [softwaremixer]
    enabled = true

    [mpd]
    enabled = true
    hostname = 127.0.0.1

    [iris]
    enabled = true
    country = ca
    locale = en_CA
    # spotify_authorization_url =
    # lastfm_authorization_url =

    [mopify]
    enabled = true

    [local]
    enabled = false
    media_dir = $HOME/Music
    scan_follow_symlinks = false
    included_file_extensions =
      .mp3

    [spotify]
    ${builtins.readFile ../../secrets/mopidy/spotify.conf}
    bitrate = 320
    volume_normalization = true
    private_session = false
    allow_cache = true
    allow_network = true
    allow_playlists = true
    search_album_count = 20
    search_artist_count = 10
    search_track_count = 50
    #toplist_countries = CA
  '';

in
{
  systemd.tmpfiles.rules = [];

  systemd.services.mopidy = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "sound.target" ];
    description = "mopidy music player daemon";
    serviceConfig = {
      ExecStart = "${mopidyEnv}/bin/mopidy --config ${mopidyConf}";
      User = "mopidy";
    };
  };

  systemd.services.mopidy-scan = {
    description = "mopidy local files scanner";
    serviceConfig = {
      ExecStart = "${mopidyEnv}/bin/mopidy --config ${mopidyConf} local scan";
      User = "mopidy";
      Type = "oneshot";
    };
  };

  users.users.mopidy = {
    inherit uid;
    group = "mopidy";
    extraGroups = [ "audio" ];
    description = "Mopidy daemon user";
    home = dataDir;
  };

  users.groups.mopidy.gid = gid;
}
