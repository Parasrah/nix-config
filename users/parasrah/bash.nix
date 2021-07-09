{ fun, aliases, isNixOS, ... }:
let
  shellAliases = with builtins; fun.pipe
    [ (map (pair: { "${elemAt pair 0}" = elemAt pair 1; }))
      (fun.lists.foldl fun.attrsets.recursiveUpdate {})
    ]
    aliases;
in
{
  inherit shellAliases;

  enable = true;

  initExtra =
    let
      gnupgInit =
        fun.strings.optionalString isNixOS ''
          unset SSH_AGENT_PID
          if [ "''${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
            export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
          fi
        '';

    in
    ''
      # this is okay because home manager ensures it's only loaded once
      . $HOME/.profile

      # vim mode
      set -o vi

      eval "$(zoxide init bash)"
      eval "$(starship init bash)"
      eval "$(direnv hook bash)"

      ${gnupgInit}

      # gpg (pinentry)
      export GPG_TTY=$(tty)
      gpg-connect-agent updatestartuptty /bye >/dev/null
    '';

  profileExtra = ''
    if [ -n "$__PROFILE_SOURCED" ]; then return; fi
    export __PROFILE_SOURCED=1
  '';
}
