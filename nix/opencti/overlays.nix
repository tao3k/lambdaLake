{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  l = nixpkgs.lib // builtins;

  patches = src: path:
    map (v: "${src}/opencti-platform/${path}/patch" + "/${v}") (l.attrNames (l.readDir "${src}/opencti-platform/${path}/patch"));
in {
  opencti = final: prev: {
    opencti-sources = prev.callPackage ./packages/_sources/generated.nix {};

    opencti-python = final.poetry2nix.mkPoetryEnv {
      projectDir = ./packages/python;
      overrides = cell.lib.nixpkgs.poetry2nix.overrides.withDefaults (import ./packages/python/overrides.nix);
    };

    opencti-patchSrc = prev.applyPatches {
      name = "opencti-patch-src";
      src = final.opencti-sources.opencti.src;
      patches = [
        (prev.fetchpatch {
          url = "https://github.com/GTrunSec/opencti/commit/ba221a7465f8d9d5ca6d3d1f970312c994e2bc27.patch";
          hash = "sha256-vU4q2qCb7rfl0PS5iGnnyWD6KZqu3i/MmYPx5BbGHec=";
        })
      ];
    };
    opencti-front = (import (final.opencti-patchSrc + "/opencti-platform/opencti-front") {pkgs = prev;}).overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [final.python3];
      preBuild = ''
        yarn build:standalone
      '';
      buildPhase = ''
        mkdir -p $out/build
        cp --recursive ./builder/prod/build/* $out/build
      '';
    });
    opencti-graphql = (import (final.opencti-patchSrc + "/opencti-platform/opencti-graphql") {pkgs = prev;}).overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [final.opencti-python];
      buildPhase = ''
        yarn build:prod
      '';
      preInstall = ''
        mkdir -p $out/{build,static}
        cp --recursive ./build/* $out/build
        cp --recursive ./static/* $out/static
      '';
    });
  };
}
