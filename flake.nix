{
  nixConfig.extra-substituters = ["https://zeek.cachix.org"];
  nixConfig.extra-trusted-public-keys = ["zeek.cachix.org-1:Jv0hB/P5eF7RQUZgSQiVqzqzgweP29YIwpSiukGlDWQ="];

  inputs = {
    nixpkgs.follows = "cells-lab/nixpkgs";
    nixos.follows = "hive/nixos";
  };

  inputs = {
    cells-lab.url = "github:gtrunsec/cells-lab";
    std-data-collection.follows = "cells-lab/std-data-collection";

    std.follows = "cells-lab/std";

    org-roam-book-template.follows = "cells-lab/org-roam-book-template";

    hive.url = "github:gtrunsec/hive";

    desci.url = "github:gtrunsec/desci";
    desci.inputs.std.follows = "std";
  };

  outputs = {
    self,
    std,
    hive,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      cellsFrom = ./nix;

      cellBlocks = with std.blockTypes;
        [
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

          (functions "nixosModules")
          (functions "homeModules")
          (functions "overlays")

          (data "homeConfigurations")
          (data "nixosConfigurations")

          (files "configFiles")
          (files "containerJobs")
          (files "dockerComposes")
          (data "schemaProfiles")

          (data "consulProfiles")
          (data "nomadJobs")
          (data "terranix")

          (data "cargoMakeJobs")
        ]
        ++ [
          (containers "containers")
        ];
    } {
      devShells = inputs.std.harvest inputs.self [["automation" "devshells"]];
      overlays = (inputs.std.harvest inputs.self [["opencti" "overlays"]]).x86_64-linux;
    } {
      nixosConfigurations = hive.lib.nixosConfigurations "nixosConfigurations" self;
    };
}
