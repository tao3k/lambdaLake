{
  inputs,
  cell,
  ...
}: let
  inherit (cell) nomadJobs;
  inherit (inputs.cells-lab._writers.lib) writeConfig;
in {
  # nomad-hydration = makeConfiguration {
  #   name = "misp-nomad-hydration-dev";
  #   target = "nomad";
  #   source = nomadJobs.hydration {
  #     driver = "podman";
  #   };
  #   format = "json";
  # };
}
