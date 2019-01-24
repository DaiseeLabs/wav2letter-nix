{ stdenv, fetchFromGitHub, cmake, mkl, openmpi }:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "gloo-${version}";
  version = "7f3995bde02b16fe33808ff298973941d9d87f1e";

  src = fetchFromGitHub {
    owner = "facebookincubator";
    repo = "gloo";
    rev = version;
    sha256 = "1nng8iwhjb2cr3gzq3all2s0igzphzmryg65lcws3mydznxkh1zj";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ openmpi ];

  preConfigure = ''
    cmakeFlags+="-DUSE_MPI=ON"
  '';

  meta = {
    description = "Collective communications library with various primitives for multi-machine training.";

    homepage    = "https://github.com/facebookincubator/gloo";
    license     = licenses.bsd3;
    platforms   = platforms.all;
    maintainers = with maintainers; [ ];
  };
}
