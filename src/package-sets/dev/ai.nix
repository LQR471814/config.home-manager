{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  claude-code
  antigravity-fhs
  codex
  # upscayl-ncnn
]
