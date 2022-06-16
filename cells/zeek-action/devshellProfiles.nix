{
  inputs,
  cell,
}: let
  inherit (cell) devshellProfiles;
in {
  default = _: {
    imports = [inputs.cells.zeek.devshellProfiles.default];
    commands = [
      {
        name = "zeek-lint";
        command = ''
          set -euo pipefail
          for path in $(find "$@" -name '*.zeek')
          do
             zeek "$path" >/dev/null
          done
        '';
        category = "zeek-action";
        help = "Check Zeek Scripts Syntax | zeek-lint <your scripts dir>";
      }
      {
        name = "zeek-btest";
        command = ''
          set -euo pipefail
          cd "$@"
          btest --show-all
        '';
        category = "zeek-action";
        help = "Run btest in your Zeek Scripts Project | zeek-btest <your testing dir>";
      }
      {
        name = "spicy-compile";
        command = ''
          name=$@
          cd $PRJ_ROOT/analyzer
          spicyz -o $name-analyzer.hlto analyzer.evt zeek_analyzer.spicy analyzer.spicy
        '';
      }
    ];
  };
}
