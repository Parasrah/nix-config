{ mods, username, homeDirectory }:

# input from `imports`
{ pkgs, config, lib, inputs, system, ... }:
let
  fun =
    import ../../fun { inherit pkgs; };

  user =
    fun.pipe
      [
        (fun.lists.map (mod: mod {
          inherit username homeDirectory pkgs lib fun inputs;
          inherit (config.system) stateVersion;
        }))
        (fun.lists.map (x: x.os or { }))
        (fun.lists.foldl fun.recursiveUpdateConcat { })
      ]
      mods;

  homeManagerConfig =
    import ./create-home-config.nix
      {
        inherit username homeDirectory pkgs lib fun inputs system mods;
      };

in
assert builtins.isString user.home;
assert builtins.isAttrs homeManagerConfig;
assert builtins.isAttrs homeManagerConfig.home;
assert builtins.isString homeManagerConfig.home.homeDirectory;

{
  users.users."${username}" = user;

  home-manager.users."${username}" = homeManagerConfig;
}
