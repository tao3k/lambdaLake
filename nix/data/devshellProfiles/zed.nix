inputs: {
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (inputs.cells.zeek.packages) zed;
in {
  commands = [
    # {
    #   package = zed;
    #   category = "data";
    # }
    # {
    #   name = "zed-explore";
    #   category = "data";
    #   command = "${zed}/bin/zed -Z $@";
    #   help = "Example: zed-explore conn.log";
    # }
  ];
}
