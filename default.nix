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
  gearmulator = callPackage ./pkgs/gearmulator { };
  loomer-aspect = callPackage ./pkgs/loomer/aspect.nix { };
  pianoteq = callPackage ./pkgs/pianoteq { };
  redux = callPackage ./pkgs/redux { };
  renoise = callPackage ./pkgs/renoise { };
}
