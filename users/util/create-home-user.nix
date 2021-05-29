{ mods, username, homeDirectory, stateVersion }:

{ extraSpecialArgs, system, pkgs }:
let
  inherit (pkgs) lib;

  fun =
    import ../../fun { inherit pkgs; };

in
{
  inherit system homeDirectory username extraSpecialArgs pkgs;

  configuration = { pkgs, inputs, ... }:
    let
      payload =
        { inherit stateVersion system homeDirectory username pkgs lib fun inputs; };

    in
    fun.pipe
      [
        (fun.lists.map (mod: mod payload))
        (fun.lists.map (x: x.homemanager))
        (fun.lists.foldl fun.recursiveUpdateConcat { })
      ]
      (mods ++ [
        ({ ... }: {
          homemanager = {
            nixpkgs = import ../../cfg/pkgs { inherit system inputs; };
          };
        })
      ]);
}
