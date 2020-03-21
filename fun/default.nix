{ pkgs }:

let
  lib =
    pkgs.lib;

in
with lib; {
  inherit lists strings;

}
