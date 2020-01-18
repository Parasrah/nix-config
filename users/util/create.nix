{ username, homemanager, user }:

{ pkgs, config, ... }:

# TODO: allow imports

{
  users.users."${username}" = user;
  home-manager.users."${username}" = {
    nixpkgs.config = import ../../cfg/pkgsConfig { inherit config; };
  } // homemanager pkgs;
}
