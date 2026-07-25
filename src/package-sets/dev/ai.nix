{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    claude-code
    antigravity-fhs
    codex
    ;
in
[
  claude-code
  antigravity-fhs
  codex
  # upscayl-ncnn
]
