{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  nodejs
  deno
  pnpm
  mermaid-cli

  marksman
  biome
  vtsls
  vscode-langservers-extracted
  tailwindcss-language-server
  svelte-language-server
]
