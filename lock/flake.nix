{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/3a86856a13c88c8c64ea32082a851fefc79aa700";

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
