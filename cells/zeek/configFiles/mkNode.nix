{
  inputs,
  cell,
}: {
  name,
  host,
  interface,
  cores ? 1,
  # "pf_ring" "af_packet"
  method ? "af_packet",
}: let
  inherit (inputs) nixpkgs;
  toCores =
    nixpkgs.lib.concatStringsSep ""
    ((a: (builtins.genList (x:
        if x == (a - 1)
        then toString x
        else toString x + ",")
      a))
      cores);

  methodSetting = nixpkgs.lib.optionalString (method == "af_packet") ''
    af_packet_fanout_id=23
    af_packet_fanout_mode=AF_Packet::FANOUT_HASH
    af_packet_buffer_size=128*1024*1024
  '';
in
  nixpkgs.writeText name ''
    [logger]
    type = logger
    host=${host}

    [manager]
    type=manager
    host=${host}

    [proxy-1]
    type=proxy
    host=${host}

    [worker-1]
    type=worker
    host=${host}
    interface=${method}::${interface}
    lb_procs=${toString cores}
    pin_cpus=${toCores}
    lb_method=${
      if method == "af_packet"
      then "custom"
      else "pr_ring"
    }
    ${methodSetting}
  ''
