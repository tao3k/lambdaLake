{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs.cells-lab._writers.lib) writeConfig;

  name = "opencti-nomad-nixos";
in {
}
#   common = branch:
#       writeConfig
#       inherit name;
#       target = "nomad";
#       source = nomadJobs.nixos-node {
#       format = "json";
#     };
# in {
#   dev = common "dev";
#   hydration.dev = common "dev" // {};
# }

