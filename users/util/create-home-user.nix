{ mods, username, stateVersion }:

passthrough@{ system, ... }:

assert builtins.isString stateVersion;
assert builtins.isString username;
assert builtins.isList mods;
let
  homeDirectory =
    "/home/${username}/";

in
({
  inherit username homeDirectory;

  configuration = { pkgs, config, lib, inputs, ... }:
    let
      fun =
        import ../../fun { inherit pkgs; };

      homemanager =
        fun.pipe
          [
            (fun.lists.map (mod: mod { inherit username pkgs lib fun inputs; }))
            (fun.lists.map (x: x.homemanager))
            (fun.lists.foldl fun.recursiveUpdateConcat { })
          ]
          (mods ++ [{ home.homeDirectory = homeDirectory; }]);

    in
    assert builtins.isList homemanager;

    fun.recursiveUpdateConcat
      ({
        nixpkgs.config = import ../../cfg/pkgsConfig { inherit inputs system config; };
        home.stateVersion = stateVersion;
        nixpkgs.overlays = [
          (import ../../pkgs)
        ];
      })
      homemanager;
} // passthrough)
