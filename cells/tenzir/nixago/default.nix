{
  inputs,
  cell,
}:let
  inherit (inputs) std nixpkgs data-merge;
in {
  vast = std.std.lib.mkNixago {
    configData = (cell.config.vast {});
    output = "infra/tenzir/prod/vast.yaml";
    format = "yaml";
    hook.mode = "copy"; # already useful before entering the devshell
  };
}
