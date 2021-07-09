{ fun, paths, env, aliases, ... }:
let
  surroundedPaths =
    builtins.map (x: "\"${x}\"") paths;

  joinedPath =
    builtins.concatStringsSep ", " surroundedPaths;

  shellAliases = with builtins; fun.pipe
    [ (builtins.map (pair: '', "alias ${elemAt pair 0} = ${elemAt pair 1}"''))
      (builtins.concatStringsSep "\n    ")
    ]
    aliases;

in
''
  path = [${joinedPath}]
  prompt = "__zoxide_hook;__zoxide_prompt"
  skip_welcome_message = true
  rm_always_trash = false
  ctrlc_exit = false
  complete_from_path = true
  startup = [ "zoxide init nushell --hook prompt | save ~/.zoxide.nu"
      , "source ~/.zoxide.nu"
      , "def unlines [] { str collect (char newline) }"
      ${shellAliases}
      ]

  [env]
  KAKOUNE_POSIX_SHELL = "${env.kakPosixShell}"
  EDITOR = "${env.editor}"
  VISUAL = "${env.visual}"
  TERMINAL = "${env.terminal}"
  DOTFILES = "${env.dotfiles}"
  KAKCONFIG = "${env.kak}"
  NIX = "${env.nix}"
  STARSHIP_SHELL = "nu"
  HISTFILESIZE = "100000"
  HISTSIZE = "100000"

  [line_editor]
  auto_add_history = true
  bell_style = "none"
  color_mode = "none"
  completion_prompt_limit = 100
  completion_type = "list" # circular, list, fuzzy
  edit_mode = "vi"
  history_duplicates = "ignoreconsecutive"
  history_ignore_space = true
  keyseq_timeout_ms = 50
  max_history_size = 100000
  tab_stop = 4

  [textview]
  colored_output = true
  grid = false
  header = true
  line_numbers = true
  pager = "less"
  paging_mode = "QuitIfOneScreen"
  snip = true
  tab_width = 4
  term_width = "default"
  theme = "Gruvbox"
  true_color = true
  use_italics = true
  vcs_modification_markers = true
  wrapping_mode = "NoWrapping"
''
