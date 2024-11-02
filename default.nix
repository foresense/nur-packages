{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (pkgs) callPackage;
in
{
  lib = import ./lib { inherit pkgs; };
  modules = import ./modules;
  overlays = import ./overlays;

  # packages
  id3edit = callPackage ./pkgs/id3edit { };
  libprinthex = callPackage ./pkgs/libprinthex { };
  gearmulator = callPackage ./pkgs/gearmulator { };
  loomer-aspect = callPackage ./pkgs/loomer/aspect.nix { };
  loomer-architect = callPackage ./pkgs/loomer/architect.nix { };
  pianoteq = callPackage ./pkgs/pianoteq { };
  redux = callPackage ./pkgs/redux { };
  renoise = callPackage ./pkgs/renoise { };
  serialosc = callPackage ./pkgs/serialosc { };
}
