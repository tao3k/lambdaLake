{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
in {
  mkNode = import ./mkNode.nix args;
  pre-zeekctl = nixpkgs.writers.writeBash "pre-zeekctl.bash" (builtins.readFile ./pre-zeekctl.bash);
}
