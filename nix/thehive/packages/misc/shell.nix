let
  pkgs = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-18.09.tar.gz") { };
in
with pkgs;

mkShell {
  buildInputs = [
    nodePackages.bower2nix
  ];
  shellHook = ''
    bower2nix bower.json bower-generated.nix
  '';
}
