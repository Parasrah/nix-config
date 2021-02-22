{ pkgs, config, inputs, system, ... }:

{
  imports =
    [
      ../users/root.nix
    ];

  environment = {
    variables = {
      TERMINAL = "kitty";
    };

    etc."inputrc" = {
      text = ''
        set meta-flag on
        set input-meta on
        set convert-meta off
        set output-meta on
        set colored-stats on
        set completion-ignore-case Off
        set show-all-if-ambiguous On
        set show-all-if-unmodified On
        set visible-stats On
      '';
    };

    shells = with pkgs; [
      unstable.nushell
    ];
  };

  fonts.fonts = with pkgs; [
    unifont
    noto-fonts
    font-awesome
    dejavu_fonts
    cascadia-code
  ];

  services = {
    printing = {
      enable = true;
    };
  };

  systemd.services = {
    configuration-perms = {
      script = ''
        chown -R root:nixos-config /etc/nixos
        chmod -R g+rw /etc/nixos
      '';
      wantedBy = [ "multi-user.target" ];
      description = "allow nixos-config user access to change system config";
    };
  };

  time = import ../cfg/time;

  nix = {
    trustedUsers = [ "root" "@wheel" ];

    package = pkgs.nixUnstable;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.overlays = [
    (import ../pkgs)
  ];

  nixpkgs.config = import ../cfg/pkgsConfig { inherit inputs system config; };

  # Security
  security.sudo = {
    wheelNeedsPassword = true;
  };

  # Users
  users.mutableUsers = true;

  users.groups.nixos-config = { };

  users.groups.vboxusers = { };

  hardware.pulseaudio.extraConfig = ''
    load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1
  '';

  # sops
  sops.defaultSopsFile = ../secrets.yaml;
  sops.gnupgHome = "/root/.gnupg";
  sops.sshKeyPaths = [ ];

  sops.secrets = {
    gpg_signing_key = { };
    wireguard_address = {
      owner = "root";
    };
    wireguard_client_private_key = {
      mode = "0440";
      owner = "root";
      group = "wheel";
    };
    wireguard_client_public_key = {
      owner = "root";
    };
    wireguard_server_public_key = {
      owner = "root";
    };
    spotify_username = { };
    spotify_password = { };
    spotify_client_id = { };
    spotify_client_secret = { };
  };
}
