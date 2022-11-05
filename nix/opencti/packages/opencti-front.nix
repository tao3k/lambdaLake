{
  buildYarnPackage,
  opencti-sources,
  mkYarnPackage,
}:
buildYarnPackage {
  inherit (opencti-sources.opencti-release) version pname;
  src = opencti-sources.opencti-release.src + "/opencti-platform/opencti-graphql";
}
