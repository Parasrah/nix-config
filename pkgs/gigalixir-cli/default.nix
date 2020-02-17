{ pkgs }:

(let
  python = let
    packageOverrides = self: super: {
      requests = super.requests.overridePythonAttrs ( old: rec {
        pname = old.pname;
        version = "2.13.0";
        src = super.fetchPypi {
          inherit pname version;
          sha256 = "5722cd09762faa01276230270ff16af7acf7c5c45d623868d9ba116f15791ce8";
        };
      });
      click = super.click.overridePythonAttrs ( old: rec {
        version = "6.7.0";
        src = super.fetchPypi {
          pname = "Click";
          inherit version;
          sha256 = "02qkfpykbq35id8glfgwc38yc430427yd05z1wc5cnld8zgicmgi";
        };
      });
      pygments = super.pygments.overridePythonAttrs ( old: rec {
        pname = old.pname;
        version = "2.2.0";
        src = super.fetchPypi {
          inherit pname version;
          sha256 = "1k78qdvir1yb1c634nkv6rbga8wv4289xarghmsbbvzhvr311bnv";
        };
      });
      stripe = super.stripe.overridePythonAttrs ( old: rec {
        pname = old.pname;
        version = "1.51.0";
        src = super.fetchPypi {
          inherit pname version;
          sha256 = "c9097e103a4c6c44fd019ee4e3fe70f529009bfc84764daf6e35a8f0fad91d21";
        };
      });
      rollbar = super.buildPythonPackage rec {
        pname = "rollbar";
        version = "0.13.11";
        src = super.fetchPypi {
          inherit pname version;
          sha256 = "76027021adf9350adcf76e1bfac5f0c68d715d9029bb7a0068a63a881fa488a7";
        };
        propagatedBuildInputs = [self.requests self.six];
        doCheck = false;
      };
    };
  in pkgs.python37.override {
    inherit packageOverrides; self = python;
  };

in
python.buildPythonApplication rec {
  pname = "gigalixir";
  version = "1.1.0";

  src = python.fetchPypi {
    inherit pname version;
    sha256 = "1rfwyi70wf6f1h0zbcrbivgy7c06vm2j1c69scqkj5b5a6idf35s";
  };

  propagatedBuildInputs = with python; [
    requests
    click
    stripe
    rollbar
    setuptools
    pytestrunner
  ];

  doCheck = false;
})
# in python.withPackages(ps: [
#   ps.buildPythonApplication rec {
#     pname = "gigalixir";
#     version = "1.1.0";

#     src = ps.fetchPypi {
#       inherit pname version;
#       sha256 = "1rfwyi70wf6f1h0zbcrbivgy7c06vm2j1c69scqkj5b5a6idf35s";
#     };

#     propagatedBuildInputs = [
#       requests
#       click
#       stripe
#       rollbar
#       setuptools
#       pytestrunner
#     ];

#     doCheck = false;
#   }
# ]
# )).env
