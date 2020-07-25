{ pkgs }:

# modified from: https://github.com/justinwoo/azuredatastudio-nix
# TODO: modify to build from source

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

in
pkgs.stdenv.mkDerivation rec {

  name = "azuredatastudio";

  src = pkgs.fetchurl {
    url = "https://github.com/microsoft/azuredatastudio/releases/download/1.14.0/azuredatastudio-linux-1.14.0.tar.gz";
    sha256 = "bf008d8dde1c41f74fd44bcce4aebf131257d622a47b7764a85718ec094610ae";
  };

  buildInputs = with pkgs; [
    libuuid
    at-spi2-core
    at_spi2_atk
  ];

  phases = "unpackPhase fixupPhase";

  targetPath = "$out/azuredatastudio";

  unpackPhase = ''
    mkdir -p ${targetPath}
    ${pkgs.gnutar}/bin/tar xf $src --strip 1 -C ${targetPath}
  '';

  rpath = with pkgs; pkgs.stdenv.lib.concatStringsSep ":" [
    atomEnv.libPath
    (
      lib.makeLibraryPath [
        libuuid
        at-spi2-core
        at_spi2_atk
        pkgs.stdenv.cc.cc.lib
      ]
    )
    targetPath
    "${targetPath}/resources/app/extensions/mssql/sqltoolsservice/Linux/2.0.0-release.40"
  ];

  fixupPhase = ''
    patchelf \
      --set-interpreter "${dynamic-linker}" \
      --set-rpath "${rpath}" \
      ${targetPath}/azuredatastudio
    mkdir -p $out/bin
    ln -s ${targetPath}/bin/azuredatastudio $out/bin/azuredatastudio
  '';
}
