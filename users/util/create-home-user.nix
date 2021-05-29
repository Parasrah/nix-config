{ mods, username, homeDirectory, stateVersion }:

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
    in
    import ./create-home-config.nix {
      inherit username homeDirectory stateVersion pkgs lib fun inputs system mods;
    };
} // passthrough)
