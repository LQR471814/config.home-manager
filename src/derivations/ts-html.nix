{
  pkgs ? import <nixpkgs> { },
  ...
}:

pkgs.stdenv.mkDerivation {
  name = "tree-sitter-html";

  nativeBuildInputs = with pkgs; [
    nodejs
    tree-sitter
  ];

  src = pkgs.fetchFromGitHub {
    owner = "tree-sitter";
    repo = "tree-sitter-html";
    rev = "5a5ca8551a179998360b4a4ca2c0f366a35acc03";
    hash = "sha256-Pd5Me1twLGOrRB3pSMVX9M8VKenTK0896aoLznjNkGo=";
  };

  installPhase = ''
    mkdir -p $out/tree-sitter-html
    cp -r . $out/tree-sitter-html
  '';
}
