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

  importLogs = nixpkgs.writeText "caretaker.yaml" (library.caretakerImporter {
    path = "/var/lib/zeek/logs/current";
    importer = "zeek";
    logs = ["conn" "smtp" "pop3" "dns" "ssh"];
    config = "--endpoint=localhost:4000 --plugins=all";
  });
}
