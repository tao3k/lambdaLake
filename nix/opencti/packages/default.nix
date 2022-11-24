{
  inputs,
  cell,
}: let
  inherit (inputs.nixpkgs-hardenedlinux.pkgs.lib) nixpkgs;
  opencti-sources = nixpkgs.callPackage ./_sources/generated.nix {};
in {
  # opencti-front = nixpkgs.callPackage ./opencti-front.nix {inherit opencti-sources;};
}
