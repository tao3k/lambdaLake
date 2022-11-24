{
  inputs,
  cell,
}: let
  inherit (cell.lib) nixpkgs;
in {
  inherit (nixpkgs) opencti-graphql opencti-front opencti-python;
}
