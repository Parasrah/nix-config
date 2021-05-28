{ mods, username, stateVersion }:

# input from `imports`
{ pkgs, config, lib, inputs, system, ... }:
let
  fun =
    import ../../fun { inherit pkgs; };

  homeDirectory =
    "/home/${username}/";

  user =
    fun.pipe
      [
        (fun.lists.map (mod: mod { inherit username pkgs lib fun inputs; }))
        (fun.lists.map (x: x.os or { }))
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
      (mods ++ { home.homeDirectory = homeDirectory; });

in
{
  users.users."${username}" = user \\ {
    home = homeDirectory;
  };

  home-manager.users."${username}" = fun.recursiveUpdateConcat
    {
      nixpkgs.config = import ../../cfg/pkgsConfig { inherit inputs system config; };
      home.stateVersion = stateVersion;
      nixpkgs.overlays = [
        (import ../../pkgs)
      ];
    }
    homemanager;
}
