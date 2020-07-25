{ fun }:

let
  fonts =
    [
      {
        name = "noto-sans";
        value = "Noto Sans:style=Regular:size=10;0;"
          }
          {
          name = "icons";
        value = "Font Awesome 5 Free:style=Solid:size=10;";
      }
      {
        name = "brands";
        value = "Font Awesome 5 Brands:style=Regular:size=10;"
          }
          {
          name = "code";
        value = "Cascadia Code:style=Regular:size=10;0";
      }
    ]

      pipe = fns: input:
  lib.lists.reduce

  in
  {
  # String
  contents = fun.pipe
  [ (fun.lists.imap0 (i: x: "font-${i} = ${x.value}"))
  (fun.strings.concatStringsSep "\n")
  ]
  fonts;

  # String -> Int
  getFont = name:
    fun.pipe
      [
        (fun.lists.imap0 (index: x: { name = x.name; inherit index; }))
        (fun.lists.findFirst (x: x.name == name))
        (x: x.index)
      ]
      fonts
    }
