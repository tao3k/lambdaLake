{
  inputs,
  cell,
}: let
  inherit (cell) packages;
  inherit (inputs) nixpkgs;
in {
  default = _: {
    commands = [
      {
        package = packages.zeek-release;
        category = "zeek";
      }
      {
        name = "zeek-script";
        package = packages.zeekscript;
        category = "zeek";
      }
      {
        package = packages.btest;
        category = "zeek";
      }
    ];
    packages = [nixpkgs.just];
  };
  action = _: {
    imports = [./action.nix];
  };
  dev = _: {
    packages = [packages.zeek-language-server];
  };
}
