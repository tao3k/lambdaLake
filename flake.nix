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
    vast2nix.inputs.zeek2nix.follows = "zeek2nix";

    zeek2nix.url = "github:hardenedlinux/zeek2nix";
    zeek2nix.inputs.nixpkgs-hardenedlinux.follows = "nixpkgs-hardenedlinux";

    threatbus2nix.url = "github:gtrunsec/threatbus2nix";

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

      cellsFrom = ./cells;

      cellBlocks = [
        (std.blockTypes.installables "packages")

        (std.blockTypes.nixago "nixago")

        (std.blockTypes.data "config")

        (std.blockTypes.functions "devshellProfiles")
        (std.blockTypes.devshells "devshells")

        (std.blockTypes.runnables "entrypoints")
        (std.blockTypes.runnables "onPremises")

        (std.blockTypes.functions "generators")
        (std.blockTypes.functions "lib")

        (std.blockTypes.functions "nixosProfiles")
        (std.blockTypes.functions "microvmProfiles")

        (std.blockTypes.files "configFiles")
        (std.blockTypes.data "containerJobs")
        (std.blockTypes.data "schemaProfiles")

        (std.blockTypes.data "consulProfiles")
        (std.blockTypes.data "nomadJobs")
        (std.blockTypes.data "terranix")

        (std.blockTypes.data "cargoMakeJobs")
        (std.blockTypes.data "waterwheelJobs")
      ];
    } {
      devShells = inputs.std.harvest inputs.self [["main" "devshells"] ["zeek" "devshells"]];
    };
}
