{ fetchFromGitHub, stdenv, fetchurl, cmake, arrayfire, mkl, glog, gflags, libsndfile, flashlight, fftw, fftwSinglePrec, libogg, libvorbis, flac, kenlm, lzma}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "wav2letter${version}";
  version = "304b62d1f9c4d0c22eec3c4ae1e2689b441f4331";
  src = fetchFromGitHub {
    owner = "facebookresearch";
    repo = "wav2letter";
    rev = version;
    sha256 = "03i8nj8h32n4s7is6ql3lcd51b7i8744yfbs5b1qmqxkbbgni5bk";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ arrayfire glog gflags mkl libsndfile flashlight fftw fftwSinglePrec libogg libvorbis flac kenlm lzma];

  preConfigure = ''
    cmakeFlags+="-DCRITERION_BACKEND=CPU -DBUILD_TESTS=OFF"
    MKLROOT=${mkl}
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir $out/lib
    cp Test Train Decoder $out/bin
    cp libwav2letter++.a $out/lib
  '';

  meta = {
    description = "Facebook AI Research Automatic Speech Recognition Toolkit";
    homepage    = "https://github.com/facebookresearch/wav2letter";
    license     = licenses.bsd3;
    platforms   = platforms.all;
    maintainers = with maintainers; [ ];
  };
}
