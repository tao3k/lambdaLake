{
  inputs,
  cell,
}: let
  inherit (inputs.std) data-merge;
  inherit (cell) lib;
  inherit (inputs) nixpkgs;
in {
  importLogs = nixpkgs.writeText "caretaker.yaml" (lib.caretakerImporter {
    path = "/var/lib/zeek/logs/current";
    importer = "zeek";
    logs = ["conn" "smtp" "pop3" "dns" "ssh"];
    config = "--endpoint=localhost:4000 --plugins=all";
  });
}
