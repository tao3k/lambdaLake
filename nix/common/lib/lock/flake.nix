{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/6ccc4a59c3f1b56d039d93da52696633e641bc71";

    sbt.url = "github:zaninime/sbt-derivation";
    sbt.inputs.nixpkgs.follows = "nixpkgs";

    bower2nix.url = "github:rvl/bower2nix?ref=refs/pull/23/head";
    bower2nix.flake= false;

    npm-buildpackage.url = "github:serokell/nix-npm-buildpackage";
    npm-buildpackage.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, ... }@inputs: {
    inherit inputs;
  };
}
