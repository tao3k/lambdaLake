{
  inputs,
  cell,
}: let
  inherit (cell) generator;
  inherit (inputs.cells.main.library) lambda-microvm-lab;
in {
  nomad.vast = {
    prod = lambda-microvm-lab.nixosConfigurations.nomad-tenzir-vast.extendModules {
      modules = [
        ./nomad-vast.nix
        {
          _module.args = {
            inherit generator;
          };
        }
      ];
    };

    dev = lambda-microvm-lab.nixosConfigurations.nomad-tenzir-vast.extendModules {
      modules = [
        ./nomad-vast.nix
        {
          _module.args = {
            inherit generator;
          };
        }
      ];
    };
  };
}
