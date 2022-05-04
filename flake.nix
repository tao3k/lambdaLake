{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    latest.url = "github:NixOS/nixpkgs/master";

    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";

    data-merge.url = "github:divnix/data-merge";
    data-merge.inputs.nixpkgs.follows = "nixpkgs";

    yants.url = "github:divnix/yants";
    yants.inputs.nixpkgs.follows = "nixpkgs";

    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;

    #cells-lab.url = "/home/gtrun/ghq/github.com/GTrunSec/DevSecOps-cells";
    cells-lab.url = "github:gtrunsec/DevSecOps-cells";

    org-roam-book-template.url = "github:gtrunsec/org-roam-book-template";
    org-roam-book-template.inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs = {
    vast2nix.url = "github:gtrunsec/vast2nix";
    zeek2nix.url = "github:hardenedlinux/zeek2nix";
    threatbus2nix.url = "github:gtrunsec/threatbus2nix";

    nixpkgs-hardienedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";
  };

  outputs = {std, ...} @ inputs:
    std.grow {
      inherit inputs;
      cellsFrom = ./cells;

      organelles = [
        (std.installables "packages")

        (std.devshells "devshellProfiles")

        (std.runnables "entrypoints")
        (std.runnables "onPremises")

        (std.functions "generators")
        (std.functions "library")

        (std.data "configFiles")
        (std.data "nixosProfiles")
        (std.data "containerJobs")
        (std.data "schemaProfiles")

        (std.data "consulProfiles")
        (std.data "nomadJobs")
        (std.data "terranix")

        (std.data "cargoMakeJobs")
        (std.data "waterwheelJobs")
      ];
    };
}
