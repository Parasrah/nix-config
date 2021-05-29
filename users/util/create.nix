# type Username = String
# type Mod
#   = { username: Username, pkgs: Pkgs }
#   -> { os : Config.Users.User, homemanager: Pkgs -> HomeManager.Users.User }
#
# { mods: List Mod, username: String }
{ mods, username }:

# input from `imports`
{ pkgs, config, lib, inputs, system, ... }:
let
  fun =
    import ../../fun { inherit pkgs; };

  user =
    fun.pipe
      [
        (fun.lists.map (mod: mod { inherit username pkgs lib fun inputs; }))
        (fun.lists.map (x: x.os))
        (fun.lists.foldl fun.recursiveUpdateConcat { })
      ]
      mods;

  homemanager =
    fun.pipe
      [
        (fun.lists.map (mod: mod { inherit username pkgs lib fun inputs; }))
        (fun.lists.map (x: x.homemanager))
        (fun.lists.foldl fun.recursiveUpdateConcat { })
      ]
      mods;

in
{
  users.users."${username}" = user;

  home-manager.users."${username}" = fun.recursiveUpdateConcat
    {
      nixpkgs = import ../../cfg/pkgs { inherit inputs system; };
      home.stateVersion = "20.09";
    }
    homemanager;
}
