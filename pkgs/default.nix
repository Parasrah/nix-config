self: super:

{
  kakoune-unwrapped = super.kakoune-unwrapped.overrideAttrs (
    old: {
      version = "2021-04-21";
      src = builtins.fetchGit {
        url = "https://github.com/Parasrah/kakoune";
        ref = "daily-driver";
        rev = "97a551c4c6522adf0079b45a3a5cb1f728ff6144";
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
