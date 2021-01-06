{ pkgs, stdenv }:

let
  name = "wonderdraft";
  version = "1.1.4";

in
stdenv.mkDerivation {
  inherit name version;

  src = ./wonderdraft.deb;

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    dpkg
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
  ];

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out/bin
    dpkg -x $src $out
    cp -av $out/opt/Wonderdraft/* $out
    rm -rf $out/opt
    mv $out/Wonderdraft.x86_64 $out/bin/
    mv $out/Wonderdraft.pck $out/bin/
    substituteInPlace $out/usr/share/applications/Wonderdraft.desktop \
      --replace '/opt/Wonderdraft/Wonderdraft.x86_64' "$out/bin/Wonderdraft.x86_64" \
      --replace '/opt/Wonderdraft' $out \
      --replace '/opt/Wonderdraft/Wonderdraft.png' "$out/Wonderdraft.png"
  '';
}
