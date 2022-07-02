{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
in {
  mkNode = import ./mkNode.nix args;
  pre-zeekctl = ./pre-zeekctl.bash;
}
