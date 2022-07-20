{
  inputs,
  cell,
}: let
  inherit (inputs) zeek2nix nixpkgs-hardenedlinux nixpkgs;
in {
  zeek = zeek2nix.packages;

  inherit
    (zeek2nix.packages.${nixpkgs.system})
    zeek-release
    zeek-latest
    ;
  inherit
    (nixpkgs-hardenedlinux.packages)
    btest
    zed
    zeekscript
    zeek-language-server
    ;
}
