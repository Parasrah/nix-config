{ pkgs, utf8proc, unstable, fetchFromGitHub }:

let
  fun = import ../../fun { inherit pkgs; };

in
fun.pipe
  [ (x: (x.overrideAttrs (old: {
      version = "0.5.0";
      src = fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "87d892afa0475644e91d9c8a57b7c35491c4dc32";
        sha256 = "03f9nb2hqmmpxvzxs7lm5kdwivs27cgp53k3h0w7sp1cp3a23gm9";
      };
      buildInputs = old.buildInputs ++ [
        utf8proc
      ];
    })))
    (unstable.wrapNeovim)
    (x: x {})
    (x: (x.override {
      vimAlias = false;
      withNodeJs = true;
      withPython = false;
      withPython3 = true;
      withRuby = false;
    }))
  ] unstable.neovim-unwrapped
