{ pkgs, stdenv }:

let
  name = "dungeondraft";
  version = "1.1.4";

in
stdenv.mkDerivation {
  inherit name version;

  src = ./dungeondraft.zip;

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    unzip
  ];

  buildInputs = with pkgs; [
    xorg.libX11
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXi
    alsaLib
    libpulseaudio
    libGL
    zlib
    stdenv.cc.cc.lib
  ];

  unpackCmd = "unzip $curSrc -d ./dungeondraft";

  sourceRoot = "dungeondraft";

  installPhase = ''
    name=dungeondraft

    mkdir -p $out/bin
    mkdir -p $out/share/applications

    chmod +x Dungeondraft.x86_64

    substituteInPlace ./Dungeondraft.desktop \
      --replace '/opt/Dungeondraft/Dungeondraft.x86_64' "$out/bin/dungeondraft" \
      --replace '/opt/Dungeondraft' $out \
      --replace '/opt/Dungeondraft/Dungeondraft.png' "$out/Dungeondraft.png"

    mv ./Dungeondraft.desktop $out/share/applications/
    mv ./Dungeondraft.x86_64 "$out/$name"
    mv ./Dungeondraft.pck $out/$name.pck

    ln -s "$out/$name" "$out/bin/$name"

    mv ./* $out
  '';
}
