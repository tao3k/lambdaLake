{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs.cells._modules.lib) makeConfiguration;

  name = "opencti-nomad-container";

  common = branch:
    makeConfiguration {
      inherit name;
      target = "nomad";
      source = nomadJobs.container {
        driver = "podman";
      };
      format = "json";
    };
in {
  dev = common "dev";
}
