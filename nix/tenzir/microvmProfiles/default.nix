{
  inputs,
  cell,
}: let
  inherit (cell) generator;
  inherit (inputs.cells.common.lib) lambda-microvm-lab;
in {
  # nomad.vast = {
  #   prod = lambda-microvm-lab.nixosConfigurations.nomad-tenzir-vast.extendModules {
  #     modules = [
  #       cell.nixosProfiles.vast
  #       {
  #         _module.args = {
  #           inherit generator;
  #         };
  #       }
  #     ];
  #   };

  #   dev = lambda-microvm-lab.nixosConfigurations.nomad-tenzir-vast.extendModules {
  #     modules = [
  #       cell.nixosProfiles.vast
  #       {
  #         _module.args = {
  #           inherit generator;
  #         };
  #       }
  #     ];
  #   };
  # };
}
