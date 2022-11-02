{
  inputs,
  cell,
}: let
  inherit (inputs.std) data-merge;
  inherit (cell) generators lib;
  inherit (inputs.cells._modules.lib) makeConfiguration;
  inherit (inputs.cells.makeConfiguration.lib) makeConfig;
in {
  vast = {
    default.prod = makeConfig ["tenzir/config/vast/default" "prod" lib.properties.vast.configFile] (data-merge.merge generators.vast.prod {
      vast.endpoint = "192.168.1.1:4000";
    });
  };
}
