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
    opencti-sources = prev.callPackage ../packages/_sources/generated.nix {};

    opencti-patchSrc = prev.applyPatches {
      name = "opencti-patch-src";
      src = final.opencti-sources.opencti.src;
      patches = [../packages/nix.patch];
    };
    opencti-front = (import (final.opencti-patchSrc + "/opencti-platform/opencti-front") {pkgs = prev;}).overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [final.python3];
    });
    opencti-graphql = (import (final.opencti-patchSrc + "/opencti-platform/opencti-graphql") {pkgs = prev;}).overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [final.python3];
    });
  };
}
