{
  inputs,
  cell,
}: let
  inherit (cell) packages;
in {
  tuc = _: {
    commands = [
      {
        package = cell.packages.tuc;
        category = "data";
        help = "When cut doesn't cut it: https://github.com/riquito/tuc";
      }
    ];
  };
  zed = import ./zed.nix inputs;
}
