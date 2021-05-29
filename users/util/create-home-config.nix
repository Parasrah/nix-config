{ username, homeDirectory, stateVersion, pkgs, lib, fun, inputs, system, mods }:
let
  fun =
    import ../../fun { inherit pkgs; };

  homemanager =
    fun.pipe
      [
        (fun.lists.map (mod: mod { inherit username homeDirectory stateVersion system pkgs lib fun inputs; }))
        (fun.lists.map (x: x.homemanager))
        (fun.lists.foldl fun.recursiveUpdateConcat { })
      ]
      mods;

in
homemanager
