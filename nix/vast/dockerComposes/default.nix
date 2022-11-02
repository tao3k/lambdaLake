{
  inputs,
  cell,
} @ args: let
  inherit (inputs.cells.containers.lib) nixpkgs;
  inherit (inputs.cells-lab._writers.lib) writeConfig;
  inherit (inputs.std) dmerge;

  default = import ./vast-compose.nix;
in {
  dev = writeConfig "vast-compose.yaml" (default {});

  release = writeConfig "vast-compose.yaml" (default {
    version = "v2.3.1";
  });

  prod = writeConfig "vast-compose.yaml" (with dmerge; merge (default {
    version = "\${VERSION}";
  }) {
    services.vast.ports = update [0] ["\${VAST_PORT:-42000}:42000"];
  });
}
