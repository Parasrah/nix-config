{ inputs, system }:

rec {
  inherit system;

  config = {
    allowUnfree = true;
    packageOverrides = pkgs: rec {
      unstable = import inputs.nixpkgs-unstable {
        inherit system config overlays;
      };
    };
  };

  overlays = [
    (import ../../pkgs)
    (import "${inputs.dungeondraft}/overlay.nix")
    (import "${inputs.wonderdraft}/overlay.nix")
    (inputs.kakoune-cr.overlay."${system}")
  ];
}
