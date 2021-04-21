self: super:

{
  kakoune-unwrapped = super.kakoune-unwrapped.overrideAttrs (
    old: {
      version = "2020-08-04";
      src = self.fetchFromGitHub {
        owner = "mawww";
        repo = "kakoune";
        rev = "e0d2602e6a924c9a4067fa9ff23f034b906dd56d";
        sha256 = "091qzk0qs7hql0q51hix99srgma35mhdnjfd5ncfba1bmc1h8x5i";
      };
    }
  );

  webdev-browser =
    let
      desktopItem = super.writeTextFile {
        name = "webdev-browser.desktop";
        executable = false;
        text = ''
          [Desktop Entry]
          Version=1.0
          Name=WebDev
          GenericName=Web Browser
          Comment=Access the Internet
          Exec=brave --user-data-dir=".config/webdev-browser" --class="webdev-browser" %U
          StartupNotify=true
          Terminal=false
          Icon=brave-browser
          Type=Application
          Categories=Network;WebBrowser;
          MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/ftp;x-scheme-handler/http;x-scheme-handler/https;
          Actions=new-window;new-private-window;

          [Desktop Action new-window]
          Name=New Window
          Exec=brave --user-data-dir=".config/webdev-browser" --class="webdev-browser"

          [Desktop Action new-private-window]
          Name=New Incognito Window
          Exec=brave --incognito --user-data-dir=".config/webdev-browser" --class="webdev-browser"
        '';
      };
    in
    super.stdenv.mkDerivation {
      name = "webdev-browser";
      dontBuild = true;
      unpackPhase = "true";

      installPhase = ''
        mkdir -p $out/share/applications
        cp ${desktopItem} $out/share/applications
      '';
    };
}
