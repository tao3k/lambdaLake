{
  inputs,
  cell,
}: {
  default = final: prev: {
    bower2nix = import (inputs.cells.common.lib.__inputs__.bower2nix + "/release.nix") {pkgs = inputs.nixpkgs;};

    thehive-patchSrc = prev.applyPatches {
      name = "thehive-patchSrc";
      src = inputs.thehive;
      patches = [
        ./packages/bower.patch
      ];
    };

    thehive-bower = inputs.nixpkgs.buildBowerComponents {
      name = "theHive-bower";
      generated = ./packages/bower-generated.nix;
      src = final.thehive-patchSrc + "/frontend";
    };
    thehive-frontend = final.buildNpmPackage {
      name = "thehive-frontend";
      src = inputs.thehive + "/frontend";
      installPhase = "cp -r dist $out";
      npmBuild = ''
        npm run build
      '';
    };
  };
}
