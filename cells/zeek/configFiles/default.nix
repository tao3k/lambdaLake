{
  inputs,
  cell,
} @ args: {
  /*
   default = common {
   name = "default";
   host = "192.168.122.1";
   interface = "eno";
   cores = 4;
   };
   */
  mkNode = import ./mkNode.nix args;
}
