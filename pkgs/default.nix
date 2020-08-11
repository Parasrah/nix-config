self: super:

{
  neovim = super.callPackage ./neovim {};
  kakoune-unwrapped = super.callPackage ./kakoune {};
}
