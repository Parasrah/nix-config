{ rustPlatform, stdenv, fetchFromGitHub, python3 }:

rustPlatform.buildRustPackage rec {
  pname = "gitui";
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "extrawurst";
    repo = pname;
    rev = "v${version}";
    sha256 = "1ifwbi6nydh66z6cprjmz2qvy9z52rj9jg2xf054i249gy955hah";
  };

  cargoSha256 = "1454dn7k1fc4yxhbcmx0z3hj9d9srnlc2k1qp707h1vq46ib1rsf";

  nativeBuildInputs = [ python3 ];

  meta = with stdenv.lib; {
    description = "Blazing fast terminal-ui for git written in rust";
    homepage = "https://github.com/extrawurst/gitui";
    license = licenses.mit;
    maintainers = [ maintainers.parasrah ];
  };
}
