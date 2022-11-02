{
  inputs,
  cell,
}: let
  inherit (inputs) std;
in {
  vast = std.lib.dev.mkNixago {
    configData = cell.config.vast {};
    output = "infra/tenzir/prod/vast.yaml";
    format = "yaml";
    hook.mode = "copy"; # already useful before entering the devshell
  };
}
