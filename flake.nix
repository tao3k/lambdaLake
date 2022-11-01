{
  nixConfig.extra-substituters = "https://zeek.cachix.org";
  nixConfig.extra-trusted-public-keys = "zeek.cachix.org-1:Jv0hB/P5eF7RQUZgSQiVqzqzgweP29YIwpSiukGlDWQ=";

  inputs = {
    nixpkgs.follows = "cells-lab/nixpkgs";
    latest.follows = "cells-lab/latest";
  };

  inputs = {
    cells-lab.url = "github:gtrunsec/cells-lab";

    org-roam-book-template.follows = "cells-lab/org-roam-book-template";
    std.follows = "cells-lab/std";
  };

  inputs = {
    vast2nix.url = "github:gtrunsec/vast2nix";
    zeek2nix.url = "github:hardenedlinux/zeek2nix";
    # threatbus2nix.url = "github:gtrunsec/threatbus2nix";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";
    nixpkgs-hardenedlinux.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {std, ...} @ inputs:
    std.growOn {

      inherit inputs;

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      cellsFrom = ./nix;

      cellBlocks = with std.blockTypes; [
        (installables "packages")

        (nixago "nixago")

        (data "config")

        (functions "devshellProfiles")
        (devshells "devshells")

        (runnables "entrypoints")
        (runnables "onPremises")

        (functions "generators")
        (functions "lib")

        (functions "nixosProfiles")
        (functions "microvmProfiles")

        (files "configFiles")
        (data "containerJobs")
        (data "schemaProfiles")

        (data "consulProfiles")
        (data "nomadJobs")
        (data "terranix")

        (data "cargoMakeJobs")
        (data "waterwheelJobs")
      ];
    } {
      devShells = inputs.std.harvest inputs.self [["main" "devshells"] ["zeek" "devshells"]];
    };
}
