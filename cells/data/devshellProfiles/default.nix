{
  inputs,
  cell,
}: let
  inherit (cell) packages;
in {
  default = {pkgs,...}: {
    commands = [
      {
        package = inputs.nixpkgs-hardenedlinux.packages.tuc;
        # https://github.com/riquito/tuc
      }
    ];
  };
  zed = import ./zed.nix inputs;
}
