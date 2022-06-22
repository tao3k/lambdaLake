{
  inputs,
  cell,
}: let
  inherit (inputs) data-merge;
  inherit (cell) library;
  inherit (inputs) nixpkgs;
in {
  importLogs = nixpkgs.writeText "caretaker.yaml" (library.caretakerImporter {
    path = "/var/lib/zeek/logs/current";
    importer = "zeek";
    logs = ["conn" "smtp" "pop3" "dns" "ssh"];
    config = "--endpoint=localhost:4000 --plugins=all";
  });
}
