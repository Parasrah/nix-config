let
  withHomeDirectory = create: args:
    create (args // {
      homeDirectory = "/home/${args.username}/";
    });
in
{
  createNixOsUser = withHomeDirectory (import ./create-nixos-user.nix);
  createHomeUser = withHomeDirectory (import ./create-home-user.nix);
}
