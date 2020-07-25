{ fun }: { wirelessInterface, wiredInterface }:

let
  util =
    import ./util { inherit fun; }

      util.create {
      top = {
        left = [];

        right = [
          (import ./mods/volume.nix {})
          (
            import ./mods/wired-network.nix {
              interface = wiredInterface;
            }
          )
          (
            import ./mods/wireless-network.nix {
              interface = wirelessInterface;
            }
          );
          (import ./mods/date.nix {})
        ];
      };

      bottom = {
        left = [
          (import ./mods/i3.nix {})
        ];

        right = [
          (import ./mods/cpu.nix {})
          (import ./mods/memory.nix {})
        ];
      };
    }
