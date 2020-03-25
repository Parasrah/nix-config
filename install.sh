# FIXME: this does not currently work
exit 1
mv /etc/nixos /etc/nixos-backup
git clone git@github.com:Parasrah/nix-config.git /etc/nixos
cp /etc/nixos-backup/hardware-configuration.nix /etc/nixos/
