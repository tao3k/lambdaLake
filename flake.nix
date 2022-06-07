{
  nixConfig.extra-substituters = "https://zeek.cachix.org";
  nixConfig.extra-trusted-public-keys = "zeek.cachix.org-1:Jv0hB/P5eF7RQUZgSQiVqzqzgweP29YIwpSiukGlDWQ=";

  inputs = {
    nixpkgs.follows = "cells-lab/nixpkgs";
    latest.follows = "cells-lab/latest";
  };
  inputs = {
    cells-lab.url = "github:gtrunsec/cells-lab";
    yants.follows = "cells-lab/yants";
    org-roam-book-template.follows = "cells-lab/org-roam-book-template";
    std.follows = "cells-lab/std";
    data-merge.follows = "cells-lab/data-merge";
  };

  inputs = {
    vast2nix.url = "github:gtrunsec/vast2nix";
    vast2nix.inputs.zeek2nix.follows = "zeek2nix";

    zeek2nix.url = "github:hardenedlinux/zeek2nix";
    zeek2nix.inputs.nixpkgs-hardenedlinux.follows = "cells-lab/nixpkgs-hardenedlinux";

    threatbus2nix.url = "github:gtrunsec/threatbus2nix";
    nixpkgs-hardenedlinux.follows = "cells-lab/nixpkgs-hardenedlinux";
  };

  outputs = {std, ...} @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./cells;

      organelles = [
        (std.installables "packages")

        (std.functions "devshellProfiles")
        (std.devshells "devshells")

        (std.runnables "entrypoints")
        (std.runnables "onPremises")

        (std.functions "generators")
        (std.functions "library")

        (std.functions "nixosProfiles")
        (std.functions "microvmProfiles")

        (std.data "configFiles")
        (std.data "containerJobs")
        (std.data "schemaProfiles")

        (std.data "consulProfiles")
        (std.data "nomadJobs")
        (std.data "terranix")

        (std.data "cargoMakeJobs")
        (std.data "waterwheelJobs")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["main" "devshells"];
    };
}
