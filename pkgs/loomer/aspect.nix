{
  stdenv,
  lib,
  autoPatchelfHook,
  fetchurl,
  alsa-lib,
  freetype,
  libGL,
}:

stdenv.mkDerivation rec {
  pname = "aspect";
  version = "2.0.3";
  displayname = "Aspect";

  src = fetchurl {
    url = "https://lmr-dply.s3.eu-west-2.amazonaws.com/${pname}/${version}/${displayname}-${version}.tar.gz";
    hash = "sha256-30sV1yYhNWWaXEkii+FGUwfvJM/KFIHsYDLsmoryGHs=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    alsa-lib
    freetype
    stdenv.cc.cc.lib
    libGL
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/lib/vst3
    cp ${displayname} $out/bin
    cp -r ${displayname}.vst3 $out/lib/vst3
    runHook postInstall
  '';

  meta = with lib; {
    description = "Loomer Aspect - Semi Modular Polyphonic Synthesizer";
    homepage = "https://loomer.co.uk/aspect.html";
    license = licenses.unfreeRedistributable;
    mainProgram = "Aspect";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
