{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib.__inputs__) nixpkgs-hardenedlinux zeek2nix;
  inherit (inputs) nixpkgs;
in {
  inherit
    (zeek2nix.packages)
    zeek
    zeek-latest
    ;
  inherit
    (nixpkgs-hardenedlinux.packages)
    btest
    zed
    zeekscript
    # zeek-language-server
    
    ;
}
