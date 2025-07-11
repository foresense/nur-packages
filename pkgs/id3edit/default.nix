{
  lib,
  stdenv,
  fetchFromGitHub,
  binutils,
  clang,
  zlib,
  libprinthex,
}:

stdenv.mkDerivation rec {
  pname = "id3edit";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "rstemmer";
    repo = "id3edit";
    rev = "v${version}";
    hash = "sha256-4WvOQsrosy5AKxK+UB47YUgmmmGzL7/zJmWzDkHIxuQ=";
  };

  nativeBuildInputs = [
    binutils
    clang
    libprinthex
    zlib
  ];

  buildPhase = ''
    SOURCE=$(find . -type f ! -path './test/*' -name "*.c")
    HEADER="-I."
    LIBS="-lprinthex -lz"
    VERSION=$(head -n1 CHANGELOG | cut -d ' ' -f 1)

    for c in $SOURCE ; do
      echo -e "\e[1;34mCompiling $c …\e[0m"
      clang -v -DxDEBUG -DVERSION="\"$VERSION\"" -Wno-multichar --std=gnu99 $HEADER -O2 -g -c -o "$c%.*.o" $c
    done

    OBJECTS=$(find . -type f ! -path './test/*' -name "*.o")

    echo Libs: $LIBS
    echo Objects: $OBJECTS

    clang -v -o id3edit $OBJECTS $LIBS
  '';

  installPhase = ''
    mkdir -p $out/bin

    for SOURCE in id3edit id3show id3frames id3dump ; do
      install -m 755 -v $SOURCE $out/bin
    done

    strip $out/bin/id3edit
  '';

  meta = {
    description = "Id3edit is a command line tool to edit and debug ID3v2 tags of mp3 files supporting Unicode";
    homepage = "https://github.com/rstemmer/id3edit";
    changelog = "https://github.com/rstemmer/id3edit/blob/${src.rev}/CHANGELOG";
    license = lib.licenses.gpl3Only;
    mainProgram = "id3edit";
    platforms = lib.platforms.all;
  };
}
