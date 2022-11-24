{
  inputs,
  cell,
}: let
  inherit (cell.lib) mkCompose;
  inherit (inputs.cells-lab.writers.lib) writeConfig;
in {
  default = writeConfig "docker-compose.yaml" (mkCompose {});
}
