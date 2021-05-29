{ mods, username, homeDirectory }:

# input from `imports`
{ pkgs, config, lib, inputs, system, ... }:
let
  inherit (config.system) stateVersion;

  fun =
    import ../../fun { inherit pkgs; };

  payload =
    { inherit stateVersion system homeDirectory username pkgs lib fun inputs; };

  userConfig =
    fun.pipe
      [
        (fun.lists.map (mod: mod payload))
        (fun.lists.map (x: x.os))
        (fun.lists.foldl fun.recursiveUpdateConcat { })
      ]
      mods;

  homeManagerConfig =
    fun.pipe
      [
        (fun.lists.map (mod: mod payload))
        (fun.lists.map (x: x.homemanager))
        (fun.lists.foldl fun.recursiveUpdateConcat { })
      ]
      mods;

in
{
  users.users."${username}" = userConfig;

  home-manager.users."${username}" = homeManagerConfig;
}
