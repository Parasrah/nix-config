self: super:

{
  neovim = super.callPackage ./neovim {};
  kakoune-unwrapped = super.callPackage ./kakoune {};
  gigalixir-cli = super.callPackage ./gigalixir-cli {};
  sqlpackage = super.callPackage ./sqlpackage {};
  azuredatastudio = super.callPackage ./azuredatastudio {};
}
