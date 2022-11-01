{
  inputs,
  cell,
}: let
  docker = args: import ./docker.nix args;
in {
  task = docker {};
}
