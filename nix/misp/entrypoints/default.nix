{
  inputs,
  cell,
  ...
}: let
  inherit (cell) nomadJobs;
  inherit (inputs.cells-lab._writers.lib) writeConfigurationFromLang;
in {
  nomad-container = writeConfigurationFromLang {
    name = "misp-nomad-container-dev";
    source = nomadJobs.container {
      driver = "podman";
    };
    target = "nomad";
    format = "json";
  };
  # nomad-hydration = makeConfiguration {
  #   name = "misp-nomad-hydration-dev";
  #   target = "nomad";
  #   source = nomadJobs.hydration {
  #     driver = "podman";
  #   };
  #   format = "json";
  # };
}
