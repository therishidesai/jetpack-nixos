{ buildPythonApplication
, fetchFromGitHub
, smbus2
, distro
}:

buildPythonApplication rec {
  pname = "jtop";
  version = "4.2.1";
  src = fetchFromGitHub {
    owner = "rbonghi";
    repo = "jetson_stats";
    rev = version;
    sha256 = "sha256-HwtQP9mDrq5Spb1HZCTVB+xEKJ9oA/M/YBmXttl11gc=";
  };

  patches = [ ./remove_jtop_install.patch ];

  propagatedBuildInputs = [ distro smbus2 ];

  doCheck = false;
}
