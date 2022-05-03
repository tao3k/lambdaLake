{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std self;
  withCategory = category: attrset: attrset // {inherit category;};
in
  l.mapAttrs (_: std.std.lib.mkShell) {
    default = {
      extraModulesPath,
      pkgs,
      ...
    }: {
      name = "Hunting Cells Lab";
      std.docs.enable = false;
      git.hooks = {
        enable = true;
        # pre-commit.text = builtins.readFile ./pre-flight-check.sh;
      };
      imports = [
        std.std.devshellProfiles.default
        "${extraModulesPath}/git/hooks.nix"
        # inputs.cells-lab.update.devshellProfiles.default
      ];
      commands = [
        (withCategory "hexagon" {package = nixpkgs.treefmt;})
        # (withCategory "hexagon" {package = nixpkgs.colmena;})
      ];
      packages = [
        # formatters
        nixpkgs.alejandra
        nixpkgs.nodePackages.prettier
        nixpkgs.nodePackages.prettier-plugin-toml
        nixpkgs.shfmt
      ];
      devshell.startup.nodejs-setuphook =
        l.stringsWithDeps.noDepEntry
        ''
          export NODE_PATH=${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
        '';
    };
  }
