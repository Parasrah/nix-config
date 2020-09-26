self: super:

{
  neovim = super.callPackage ./neovim {};
  cascadia-code = super.callPackage ./cascadia-code {};
  kakoune-unwrapped = super.kakoune-unwrapped.overrideAttrs (
    old: {
      version = "2020-08-04";
      src = self.fetchFromGitHub {
        owner = "mawww";
        repo = "kakoune";
        rev = "e0d2602e6a924c9a4067fa9ff23f034b906dd56d";
        sha256 = "091qzk0qs7hql0q51hix99srgma35mhdnjfd5ncfba1bmc1h8x5i";
      };
    }
  );
}
