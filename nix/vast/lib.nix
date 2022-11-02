{
  inputs,
  cell,
}: {
  properties = {
    vast = {
      configFile = "config.yaml";
    };
  };
  caretakerImporter = {
    path,
    logs,
    config,
    importer ? "zeek",
  }: (map (
      x: ''
        [[watch]]
        name = "${x}"
        path = "${path}/${x}*.log"
        command = "vast ${config} import ${importer} < ${path}/${x}.log"
      ''
    )
    logs);
}
