{
  inputs,
  cell,
}: {
  host,
  interface,
  # "pf_ring" "af_packet"
  method ? "af_packet",
  workers ? [],
}: let
  inherit (inputs) nixpkgs;
  toCores = cores:
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

  workers' = nixpkgs.lib.flip nixpkgs.lib.concatMapStrings workers (
    {
      host,
      interface,
      cores,
      name,
      ...
    }: ''
      [${name}]
      type=worker
      host=${host}
      interface=${method}::${interface}
      lb_procs=${toString cores}
      pin_cpus=${toCores cores}
      lb_method=${
        if method == "af_packet"
        then "custom"
        else "pr_ring"
      }
      ${methodSetting}
    ''
  );
in
  nixpkgs.writeText "network.cfg" ''
    [logger]
    type = logger
    host=${host}

    [manager]
    type=manager
    host=${host}

    [proxy-1]
    type=proxy
    host=${host}

    ${workers'}
  ''
