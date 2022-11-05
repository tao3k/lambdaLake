{
  inputs,
  cell,
}: {
  default = _: {
    imports = [
      inputs.cells.zeek.devshellProfiles.action
      inputs.cells.vast.devshellProfiles.action
    ];
    commands = [];
  };
}
