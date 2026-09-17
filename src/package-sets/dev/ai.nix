{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    claude-code
    antigravity-fhs
    codex
    kiro-cli
    ;
in
[
  claude-code
  antigravity-fhs
  codex
  kiro-cli
  # upscayl-ncnn
]
