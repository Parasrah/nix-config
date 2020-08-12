{ stdenv, fetchzip }:

let
  version = "2007.01";

in
fetchzip rec {
  name = "cascadia-code";

  url = "https://github.com/microsoft/cascadia-code/releases/download/v${version}/CascadiaCode-${version}.zip";

  sha256 = "0kp997q4hwm0yf6c9zkpj5kl4ws4ywh0rkj03rwh4b28xa9fkgzs";

  postFetch = ''
    mkdir -p $out/share/fonts
    unzip -j $downloadedFile \*.ttf -d $out/share/fonts/truetype
  '';

  meta = with stdenv.lib; {
    description = "Monospaced font that includes programming ligatures and is designed to enhance the modern look and feel of the Windows Terminal";
    homepage = "https://github.com/microsoft/cascadia-code";
    license = licenses.ofl;
    maintainers = [ maintainers.marsam ];
    platforms = platforms.all;
  };
}
