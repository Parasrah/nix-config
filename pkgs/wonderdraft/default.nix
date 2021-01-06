{ pkgs, stdenv }:

let
  name = "wonderdraft";
  version = "1.1.4";

in
stdenv.mkDerivation {
  inherit name version;

  src = ./wonderdraft.zip;

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
  ];

  unpackCmd = "unzip $curSrc -d ./wonderdraft";

  sourceRoot = "wonderdraft";

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/applications

    chmod +x Wonderdraft.x86_64

    mv ./Wonderdraft.desktop $out/share/applications/
    mv ./Wonderdraft.x86_64 $out/bin/wonderdraft
    mv ./Wonderdraft.pck $out/bin/wonderdraft.pck

    substituteInPlace $out/share/applications/Wonderdraft.desktop \
      --replace '/opt/Wonderdraft/Wonderdraft.x86_64' "$out/bin/wonderdraft" \
      --replace '/opt/Wonderdraft' $out \
      --replace '/opt/Wonderdraft/Wonderdraft.png' "$out/Wonderdraft.png"
  '';
}
