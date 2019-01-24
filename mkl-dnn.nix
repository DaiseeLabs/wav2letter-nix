{ stdenv, fetchurl, cmake, mkl }:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "mkl-dnn-${version}";
  version = "0.17.2";

  src = fetchurl {
    url = "https://github.com/intel/mkl-dnn/archive/v${version}.tar.gz";
    sha256 = "0d2iiq6j4rmdmrzfvgbbdb3vxb1vmdw8xzaqricn10dd9wny5hsn";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ mkl ];

  preConfigure = ''
    cmakeFlags+="-DMKLDNN_USE_MKL=FULL -DWITH_TEST=OFF -DWITH_EXAMPLE=OFF"
    MKLROOT=${mkl}
    '';

  meta = {
    description = "Intel(R) Math Kernel Library for Deep Neural Networks";
    homepage    = "https://01.org/mkl-dnn";
    license     = licenses.bsd3;
    platforms   = platforms.all;
    maintainers = with maintainers; [ ];
  };
}
