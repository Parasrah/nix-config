{ fun }: { top, bottom }:

let
  background =
    "#212121";

  foreground =
    "#fafafa";

  fontsUtil =
    import ./fonts.nix { inherit fun; };

  modsUtil =
    import ./mods.nix { inherit fun; };

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

  ${fontsUtil.contents}

  modules-left = ${modsUtil.modNames top.left}
  modules-right = ${modsUtil.modNames top.right}

  [bar/bottom]
  bottom = true
  width = 100%
  height = 27

  enable-ipc = true

  background = ${background}
  foreground = ${foreground}

  line-color = ${background}
  line-size = 2

  spacing = 3
  padding-right = 4
  module-margin-left = 0
  module-margin-right = 6

  ${fontsUtil.contents}

  modules-left = ${modsUtil.modNames bottom.left}
  modules-right = ${modsUtil.modNames bottom.right}

  ${modsUtil.modsContent [ top.left, top.right, bottom.left, bottom.right ]}
''
