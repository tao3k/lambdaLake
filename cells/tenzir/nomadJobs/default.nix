{
  inputs,
  cell,
}: let
  inherit (inputs) self nixpkgs;
  nixos = {
    vast = args: import ./nixos/vast.nix args;
  };
in {
  prod = nixos.vast {
    flake = "${self.outPath}#${nixpkgs.system}.tenzir.nixosProfiles.nomad.vast.prod";
  };
}
