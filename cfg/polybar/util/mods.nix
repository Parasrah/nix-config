{ fun }:

{
  # List Mod -> String
  modNames =
    fun.pipe
      [
        fun.lists.map
        (x: x.name)
        lib.string.concatStringsSep
        " "
      ];

  # List (List Mod) -> String
  modsContent =
    fun.pipe
      [
        builtins.concatLists
        fun.lists.unique
        (fun.lists.map (x: x.value))
        (fun.lists.concatStringsSep "\n\n")
      ]
    }
