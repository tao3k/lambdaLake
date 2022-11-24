{
  buildYarnPackage,
  opencti-sources,
  mkYarnPackage,
  dream2nix,
  system,
}:
# buildYarnPackage {
#   inherit (opencti-sources.opencti-release) version pname;
#   src = opencti-sources.opencti-release.src + "/opencti-platform/opencti-graphql";
# }
(dream2nix.makeFlakeOutputs {
  systems = [system];
  config.projectRoot = ./.;
  source = opencti-sources.opencti-release.src + "/opencti-platform/opencti-front";
  settings = [
    {
      subsystemInfo.noDev = true;
      subsystemInfo.nodejs = 18;
    }
  ];
})
.packages
.${system}
.default
