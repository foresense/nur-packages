{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  alsa-lib,
  asmjit,
  clap,
  curl,
  freeglut,
  freetype,
  gtk3-x11,
  jack2,
  lerc,
  libGL,
  libdatrie,
  libepoxy,
  libselinux,
  libsepol,
  libsysprof-capture,
  libthai,
  libtiff,
  libxkbcommon,
  mesa,
  pcre2,
  pkg-config,
  sqlite,
  util-linux,
  webkitgtk,
  xorg,
  unzip,
}:
stdenv.mkDerivation {
  pname = "gearmulator";
  version = "1.3.21";

  src = fetchFromGitHub {
    owner = "dsp56300";
    repo = "gearmulator";
    rev = "020ffa444819512515cf5a8cfacb9a06ad50bf7b";
    hash = "sha256-1AXtCAuvt+vubhdkgoFatClTEM1TT4h577ybwLcJnQI=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    asmjit
    libsysprof-capture
    pkg-config
    unzip
  ];

  buildInputs = [
    clap
    alsa-lib
    curl
    freeglut
    freetype
    gtk3-x11
    jack2
    lerc
    libGL
    libdatrie
    libepoxy
    libselinux
    libsepol
    libthai
    libtiff
    libxkbcommon
    mesa
    pcre2
    sqlite
    util-linux
    webkitgtk
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdmcp
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXtst
  ];

  # patches = [ ./better_folders.patch ];

  cmakeFlags = [
    # "-Dgearmulator_BUILD_FX_PLUGIN=ON"  # DEFAULT: OFF
    "-Dgearmulator_BUILD_JUCEPLUGIN_LV2=OFF" # DEFAULT: ON
    # "-Dgearmulator_SYNTH_NODALRED2X=ON"  # DEFAULT: ON
    # "-Dgearmulator_SYNTH_OSIRUS=ON"  # DEFAULT: ON
    # "-Dgearmulator_SYNTH_OSTIRUS=ON"  # DEFAULT: ON
    # "-Dgearmulator_SYNTH_VAVRA=ON"  # DEFAULT: ON
    # "-Dgearmulator_SYNTH_XENIA=ON"  # DEFAULT: ON
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/clap/dsp56300
    cp -rt $out/lib/clap/dsp56300 ./source/mqJucePlugin/mqJucePlugin_artefacts/Release/CLAP/Vavra.clap \
      ./source/nord/n2x/n2xJucePlugin/n2xJucePlugin_artefacts/Release/CLAP/NodalRed2x.clap \
      ./source/osTIrusJucePlugin/osTIrusJucePlugin_artefacts/Release/CLAP/OsTIrus.clap \
      ./source/osirusJucePlugin/osirusJucePlugin_artefacts/Release/CLAP/Osirus.clap \
      ./source/xtJucePlugin/xtJucePlugin_artefacts/Release/CLAP/Xenia.clap

    mkdir -p $out/lib/vst/dsp56300
    cp -rt $out/lib/vst/dsp56300 ./source/mqJucePlugin/mqJucePlugin_artefacts/Release/VST/libVavra.so \
      ./source/nord/n2x/n2xJucePlugin/n2xJucePlugin_artefacts/Release/VST/libNodalRed2x.so \
      ./source/osTIrusJucePlugin/osTIrusJucePlugin_artefacts/Release/VST/libOsTIrus.so \
      ./source/osirusJucePlugin/osirusJucePlugin_artefacts/Release/VST/libOsirus.so \
      ./source/xtJucePlugin/xtJucePlugin_artefacts/Release/VST/libXenia.so

    mkdir -p $out/lib/vst3/dsp56300
    cp -rt $out/lib/vst3/dsp56300 ./source/mqJucePlugin/mqJucePlugin_artefacts/Release/VST3/Vavra.vst3 \
      ./source/nord/n2x/n2xJucePlugin/n2xJucePlugin_artefacts/Release/VST3/NodalRed2x.vst3 \
      ./source/osTIrusJucePlugin/osTIrusJucePlugin_artefacts/Release/VST3/OsTIrus.vst3 \
      ./source/osirusJucePlugin/osirusJucePlugin_artefacts/Release/VST3/Osirus.vst3 \
      ./source/xtJucePlugin/xtJucePlugin_artefacts/Release/VST3/Xenia.vst3

    runHook postInstall
  '';

  meta = {
    description = "Emulation of classic VA synths of the late 90s/2000s that are based on Motorola 56300 family DSPs";
    homepage = "https://github.com/dsp56300/gearmulator";
    sourceProvenance = [ lib.sourceTypes.fromSource ];
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.all;
  };
}
