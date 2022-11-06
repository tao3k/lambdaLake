{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.makes.lib) makeSopsScript;
in {
  # nomad-container-dev = (import ./nomad-container args).dev;

  # nomad-hydration-dev = (import ./nomad-container args).hydration.dev;

  # nomad-nixos-dev = (import ./nomad-nixos args).dev;

  # docker-compose-prod = (import ./docker-compose args).prod;
  #
  secrets-for-gpg-from-env = makeSopsScript {
    name = "opencti";
    env = {
      manifest = ./secrets-opencti.yaml;
      vars = ["OPENCTI_ADMIN_EMAIL" "OPENCTI_ADMIN_PASSWORD"];
    };
    entrypoint = "echo $OPENCTI_ADMIN_EMAIL";
    searchPaths.bin = [];
  };
}
