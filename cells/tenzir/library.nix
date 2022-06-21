{
  inputs,
  cell,
}: {
  properties = {
    vast = {
      configFile = "config.yaml";
    };
  };
  caretakerImporter = {path, logs, config}: (map (x:
    ''
    [[watch]]
    name = "${x}"
    path = "${path}/${x}*.log"
    command = "vast --config=${config} import > ${path}/${x}.log"
    ''
  ) logs);
}
