{ pkgs, ... }:
{
  enable = true;

  extensionPackages = with pkgs; [
    mopidy-spotify
    # seems broken on 20.03
    # mopidy-local-sqlite
    mopidy-iris
  ];

  configuration = ''
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
}
