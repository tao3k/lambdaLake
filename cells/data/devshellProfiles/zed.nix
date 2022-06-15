inputs: {
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (inputs.cells.zeek.packages) zed;
in {
  commands = [
    {
      package = zed;
      category = "zed";
    }
    {
      name = "zed-explore";
      command = "${zed}/bin/zed -Z $@";
    }
  ];
}
