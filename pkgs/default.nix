self: super:

{
  neovim = super.callPackage ./neovim {};
  kakoune-unwrapped = super.callPackage ./kakoune {};
  cascadia-code = super.callPackage ./cascadia-code {};
}
