self: super:

{
  neovim = super.callPackage ./neovim {};
  gigalixir-cli = super.callPackage ./gigalixir-cli {};
  sqlpackage = super.callPackage ./sqlpackage {};
  azuredatastudio = super.callPackage ./azuredatastudio {};
}
