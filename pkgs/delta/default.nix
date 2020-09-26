{ rustPlatform, stdenv, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "delta";
  version = "0.4.3";

  src = fetchFromGitHub {
    owner = "dandavison";
    repo = pname;
    rev = version;
    sha256 = "0g7jg6bxxihplxzq3ixdm24d36xd7xlwpazz8qj040m981cj123i";
  };

  cargoSha256 = "0000000000000000000000000000000000000000000000000000";

  meta = with stdenv.lib; {
    description = "A viewer for git and diff output";
    homepage = "https://github.com/dandavison/delta";
    license = licenses.mit;
    maintainers = [ maintainers.parasrah ];
  };
}
