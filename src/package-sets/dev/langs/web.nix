{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
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
    ;
in
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
