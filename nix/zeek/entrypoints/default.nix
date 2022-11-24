{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
  inherit (inputs) nixpkgs;
in {
  network = let
    config = cell.configFiles.mkNode {
      host = "192.168.122.1";
      interface = "eno";
      # "pf_ring" "af_packet"
      method = "af_packet";
      workers = [
        {
          name = "worker-1";
          host = "192.168.122.1";
          interface = "eno";
          cores = 4;
        }
        {
          name = "worker-2";
          host = "192.168.122.1";
          interface = "eno";
          cores = 4;
        }
      ];
    };
  in
    writeShellApplication {
      name = "mkdoc";
      runtimeInputs = [nixpkgs.bat];
      text = ''
        bat --paging=never ${config}
      '';
    };
}
