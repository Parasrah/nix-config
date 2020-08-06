{ unstable, fetchFromGitHub }:

unstable.kakoune-unwrapped.overrideAttrs (
  old: {
    version = "2020-08-04";
    src = fetchFromGitHub {
      owner = "mawww";
      repo = "kakoune";
      rev = "2c437cfa02ca568750182209ef6249c6975243a5";
      sha256 = "1cgkis8bywy5k8k6j4i3prikpmhh1p6zyklliyxbc89mj64kvx4s";
    };
  }
)
