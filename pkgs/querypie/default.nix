{ pkgs, appimageTools, fetchurl, ... }:

# TODO: actually get it working
appimageTools.wrapType1 {
  name = "querypie";
  src = fetchurl {
    url = "https://www.querypie.com/api/v1/download?id=282&platform=LINUX";
    sha256 = "4b6a3eaa42da5eddd099f7c211527c6cde8a8a376e1f13159ff49d4af3ca24f7";
  };
  extraPkgs = with pkgs; [ openssl_1_1 ];
}

