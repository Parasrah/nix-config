{ username, homemanager, user }:

{ pkgs, ... }:

{
  users.users."${username}" = user;
  home-manager.users."${username}" = homemanager pkgs;
}
