{
  inputs,
  cell,
}: let
  inherit (cell) dockerJobs library;
  inherit (inputs.cells._modules.library) makeConfiguration;
  inherit (inputs.cells.makes.library) makeSubstitution;

  name = "opencti-" + builtins.baseNameOf ./.;

  justfile = makeSubstitution {
    name = "justfile";
    env = {
      __argFile__ = name;
    };
    source = ./justfile;
  };
  common = branch:
    makeConfiguration {
      target = "docker-compose";
      inherit branch;
      searchPaths.file = ["${justfile}/justfile"];
      searchPaths.bin = [];
      source = dockerJobs.compose {};
      format = "yaml";
    };
in {
  prod = common "prod";
}
