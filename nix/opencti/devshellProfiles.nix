{
  inputs,
  cell,
}: {
  default = _: {
    commands = [
      {
        name = "nvfetcher-opencti";
        command = ''
          nix develop github:GTrunSec/cells-lab#devShells.x86_64-linux.update \
          --refresh --command \
          nvfetcher-update nix/opencti/packages/sources.toml
        '';
        help = "update opencti toolchain with nvfetcher";
      }
    ];
  };
}
