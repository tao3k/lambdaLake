{
  sbt,
  fetchFromGitHub,
}:
sbt.mkDerivation {
  version = "2021-03-29";
  pname = "TheHive";
  src = fetchFromGitHub {
    owner = "TheHive-Project";
    repo = "TheHive";
    rev = "0074446368ba82b55cac5af72ec83fa9b493acb5";
    fetchSubmodules = true;
    sha256 = "14jyrw7sy43ywhya854hbap9wpkqcna80xf529b6gc3mlb5nigl2";
  };

  depsSha256 = "sha256-H8N3/v9CTk8YOOpbNHJ72MK0E7CdkGs63jQW3jDbkxA=";

  HOME = ".";

  buildPhase = ''
    rm -rf build.sbt && cp ${./misc/build.sbt} build.sbt
    substituteInPlace build.sbt \
    --replace 'command = baseDirectory.value -> "grunt build"' 'command = baseDirectory.value -> "/build/source/frontend/node_modules/.bin/grunt build"' \
    --replace 'command = baseDirectory.value -> "grunt wiredep"' 'command = baseDirectory.value -> "/build/source/frontend/node_modules/.bin/grunt wiredep"' \
    --replace 'command = baseDirectory.value -> "bower install"' 'command = baseDirectory.value -> "/build/source/frontend/node_modules/.bin/bower info"' \
    --replace 'command = baseDirectory.value -> "npm install"' 'command = baseDirectory.value -> "${nodejs}/bin/npm install"'
    cp -r ${theHive_frontend}/node_modules frontend/.
    rm -rf frontend/{package.json,package-lock.json} && cp ${./misc/package.json} frontend/. && cp ${./misc/package-lock.json} frontend/.
    # WIP
    cp -r ${theHive_bower}/bower_components frontend/.
    sbt stage
  '';

  installPhase = ''
    mkdir -p $out/{bin,conf,jar,lib}
    mv target/universal/stage/bin/* $out/bin/
    mv target/universal/stage/conf/application.conf target/universal/stage/conf/application.exmaple.conf
    mv target/universal/stage/conf/* $out/conf/
    mv target/universal/stage/lib/* $out/lib/
    mv target/scala-2.12/thehive_2.12-4.1.0-1.jar  $out/jar/
  '';
}
