{ unstable, fetchFromGitHub }:

unstable.kakoune-unwrapped.overrideAttrs (
  old: {
    version = "2020-06-01";
    src = fetchFromGitHub {
      owner = "mawww";
      repo = "kakoune";
      rev = "6fa26b8dd2ac0931fe688370728c47086277d883";
      sha256 = "1sm5800j7s3ls2951hiza930vawnfg7lwpq7ycgd89ds2hij6gzh";
    };
  }
)
