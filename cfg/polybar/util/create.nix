{ pkgs, top, bottom }:

# TODO: need to actually insert modules

let
  background =
    "#212121";

  foreground =
    "#fafafa";

  fonts =
    import ./fonts.nix;

  fontContentList =
    lib.lists.imap0 (i: x: "font-${i} = ${x.value}") fonts;

  fontContentString =
    lib.strings.concatStringsSep "\n" fontContentList;

  modNames =
    mods:
      lib.string.concatStringsSep " " (
        lib.lists.map (x: x.name) mods
      )
    

in
''
[bar/top]
width = 100%
height = 34

enable-ipc = true

background = ${background}
foreground = ${foreground}

line-color = ${background}
line-size = 16

spacing = 2
padding-right = 5
module-margin = 4

${fontContentString}

modules-left = ${modNames top.left}
modules-right = ${modNames top.right}

[bar/bottom]
bottom = true
width = 100%
height = 27

enable-ipc = true

background = ${background}
foreground = ${forground}

line-color = ${background}
line-size = 2

spacing = 3
padding-right = 4
module-margin-left = 0
module-margin-right = 6

${fontContentString}

modules-left = ${modNames bottom.left}
modules-right = ${modNmaes bottom.right}
''
