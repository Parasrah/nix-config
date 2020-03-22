{ pkgs }:

let
  lib =
    pkgs.lib;

in
with lib; rec {
  inherit lists strings attrsets;
  pipe = import ./pipe.nix { inherit lib; };
  recursiveUpdateConcat = import ./recursiveUpdateConcat.nix { inherit lib pipe; };
}
