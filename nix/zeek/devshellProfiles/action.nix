{
  config,
  lib,
  pkgs,
  ...
}: {
  commands = [
    {
      name = "zeek-lint";
      category = "zeek-action";
      command = ''
        set -euo pipefail
        for path in $(find "$@" -name '*.zeek')
        do
           zeek "$path" >/dev/null
        done
      '';
      help = "Check Zeek Scripts Syntax | zeek-lint <your scripts dir>";
    }
    {
      name = "zeek-btest";
      category = "zeek-action";
      command = ''
        set -euo pipefail
        cd "$@"
        btest --show-all
      '';
      help = "Run btest in your Zeek Scripts Project | zeek-btest <your testing dir>";
    }
    {
      name = "spicy-compile";
      category = "zeek-action";
      command = ''
        name=$@
        cd $PRJ_ROOT/analyzer
        spicyz -o $name-analyzer.hlto analyzer.evt zeek_analyzer.spicy analyzer.spicy
      '';
    }
  ];
}
