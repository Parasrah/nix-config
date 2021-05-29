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

    unstable.recursive
  ];

  programs = {
    ssh.startAgent = false;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "curses";
    };
  };

  services = {
    yubikey-agent = {
      enable = true;
    };

    printing = {
      enable = true;
    };

    pcscd = {
      enable = true;
    };

    udev.packages = with pkgs; [
      yubikey-personalization
    ];
  };

  systemd.services.configuration-perms = {
    script = ''
      chown -R root:nixos-config /etc/nixos
      chmod -R g+rw /etc/nixos
    '';
    wantedBy = [ "multi-user.target" ];
    description = "allow nixos-config user access to change system config";
  };

  systemd.services.wg-quick-wg0.serviceConfig.SupplementaryGroups = [
    config.users.groups.keys.name
  ];

  time = import ../cfg/time;

  nix = {
    trustedUsers = [ "root" "@wheel" ];

    package = pkgs.nixUnstable;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = import ../cfg/pkgs { inherit inputs system; };

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
  sops.defaultSopsFile = "${inputs.secrets}/secrets.yaml";
  sops.gnupgHome = "/root/.gnupg";
  sops.sshKeyPaths = [ ];

  sops.secrets = {
    wireguard_lexi_private_key = { };
  };

  # home manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
}
