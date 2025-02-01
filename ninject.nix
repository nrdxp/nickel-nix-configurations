let
  pkgs = import <nixpkgs> {};

  # Helper function to check if value is an attrset
  isAttrs = value: builtins.isAttrs value && !pkgs.lib.isDerivation value;

  # Fixed-point combinator for recursive traversal
  fix = f: let x = f x; in x;

  # Main transformer function
  transformer = pattern: transform:
    fix (
      self: attrs:
        if builtins.isAttrs attrs
        then
          builtins.mapAttrs (
            name: value: let
              matcher = builtins.match pattern value;
              isString = builtins.isString value;
              notNull = matcher != null;
              matches = isString && notNull && matcher != [];
            in
              if matches
              then transform value (builtins.head matcher)
              else if isAttrs value
              then self value
              else value
          )
          attrs
        else attrs
    );

  transform = str: pname: builtins.replaceStrings ["@${pname}@"] [(toString pkgs.${pname})] str;
in
  {jsonStr}: let
    final = transformer ".*@([a-zA-Z0-9_-]*)@.*" transform (builtins.fromJSON jsonStr);
  in
    builtins.deepSeq final final.output
