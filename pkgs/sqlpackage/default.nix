{ stdenv, fetchzip }:

stdenv.mkDerivation {
  name = "sqlpackage";

  version = "18.4.1";

  src = fetchzip {
    url = "https://download.microsoft.com/download/d/e/b/deb7b081-a3dc-47ea-8f2a-48cd8e486036/sqlpackage-linux-x64-en-US-15.0.4630.1.zip";
    sha256 = "1k2l6k3s15v63r1ygsczkhy9158h1z9jsshj3vxj9q7vi50k8hcc";
    stripRoot = false;
  };

  dontBuild = true;

  buildInputs = [

  ];
}
