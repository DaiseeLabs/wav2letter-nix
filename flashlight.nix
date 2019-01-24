{ stdenv, fetchurl, cmake, arrayfire, mkl, glog, gflags, mkl-dnn, openmpi, git, gloo}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "flashlight-${version}";
  version = "349e8cfa261a70dd30ab336c44c6985b45555141";

  src = fetchurl {
    url = "https://github.com/facebookresearch/flashlight/archive/${version}.tar.gz";
    sha256 = "0pr8mykqqy9gks6wvca9k4wix0kz2rxqblhzpn7arvs1givpcscn";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ arrayfire glog gflags mkl mkl-dnn openmpi git gloo ];

  preConfigure = ''
    cmakeFlags+="-DFLASHLIGHT_BACKEND=CPU -DFL_BUILD_TESTS=OFF -DFL_BUILD_EXAMPLES=OFF"
    MKLROOT=${mkl}

    # They want to clone dependencies :(
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt
    SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
  '';

  meta = {
    description = "A C++ standalone library for machine learning";
    homepage    = "https://fl.readthedocs.io/en/latest/";
    license     = licenses.bsd3;
    platforms   = platforms.all;
    maintainers = with maintainers; [ ];
  };
}
