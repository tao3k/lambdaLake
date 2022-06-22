{
  inputs,
  cell,
}: let
  inherit (inputs) data-merge;
  inherit (cell) library;
  inherit (inputs) nixpkgs;
in {
  vast = {
    db-directory ? "vast.db",
    file-verbosity ? ["quiet" "error" "warning" "info" "verbose" "debug" "trace"],
  } @ args: {
    vast =
      (
        data-merge.merge
        (import ./vast/metrics.nix args)
        (data-merge.decorate (import ./vast/start.nix args) {})
      )
      // (import ./vast/default.nix args);
  };
}
