{ fetchFromGitHub, stdenv, fetchurl, cmake, boost, lzma }:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "kenlm-${version}";
  version = "e47088ddfae810a5ee4c8a9923b5f8071bed1ae8";

  src = fetchFromGitHub {
    owner = "kpu";
    repo = "kenlm";
    rev = version;
    sha256 = "0jzf58lpa5siha6jgbpgy0kfgdzwj5jxgz8fm2dp4szwfhmilhvr";
  };

  # Can't work out how to get cmake to install any libraries, so manhandle them.
  # We also manually copy the lm source directory for headers :(
  postInstall = ''
    cp -r lib $out
    cp -r ../lm $out
    cp -r ../util $out
  '';

  nativeBuildInputs = [ cmake ];
  buildInputs = [ boost lzma ];

  meta = {
    description = "KenLM: Faster and Smaller Language Model Queries";
    homepage    = "http://kheafield.com/code/kenlm/";
    license     = licenses.lgpl;
    platforms   = platforms.all;
    maintainers = with maintainers; [ ];
  };
}
