{
  pkgs ? import <nixpkgs> { },
  ...
}:

pkgs.stdenv.mkDerivation {
  name = "tree-sitter-markdown";

  nativeBuildInputs = with pkgs; [
    nodejs
    tree-sitter
  ];

  src = pkgs.fetchFromGitHub {
    owner = "tree-sitter-grammars";
    repo = "tree-sitter-markdown";
    rev = "aca7767daa8bbe3daddafc312c34be88383c828b";
    hash = "sha256-JJCFksPDwaiOmU+nZ3PHeLHlPKWTZBTnqcD/tQorWdU=";
  };

  installPhase = ''
    mkdir -p $out/tree-sitter-markdown
    cp -r . $out/tree-sitter-markdown
  '';
}
