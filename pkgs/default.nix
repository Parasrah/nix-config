self: super:

{
  neovim = super.callPackage ./neovim {};
  sqlpackage = super.callPackage ./sqlpackage {};
  azuredatastudio = super.callPackage ./azuredatastudio {};
}
