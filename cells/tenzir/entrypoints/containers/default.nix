{
  inputs,
  cell,
}: let
  inherit (cell) containerJobs;
  inherit (inputs.cells._modules.lib) makeConfiguration;
  inherit (inputs.cells.makes.lib) makeSubstitution;
  inherit (inputs.cells.containers.lib) makePodmanJobs makeDockerComposeJobs;

  name = "tenzir-" + builtins.baseNameOf ./.;

  justfile = makeSubstitution {
    name = "justfile";
    env = {
      __argFile__ = name;
    };
    source = ./justfile;
  };
in {
  podman = {
    vast.release = makePodmanJobs (containerJobs.vast "release");
  };

  docker-compose = {
    vast.release =
      (makeDockerComposeJobs "release" (containerJobs.vast.compose {}))
      // {
        searchPaths.file = [
          "${justfile}/justfile"
        ];
        searchPaths.bin = [];
      };
  };
}
