{
  final,
  prev,

  stdenv,
  fetchFromGitHub,

  nodejs,
  tree-sitter,
}:

stdenv.mkDerivation {
  name = "ts-markdown";

  nativeBuildInputs = [
    nodejs
    tree-sitter
  ];

  src = fetchFromGitHub {
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
