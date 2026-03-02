{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  claude-code
  antigravity-fhs
  upscayl-ncnn
]
