{ pkgs, ... }:
{
  customLanguages = {
    nu = {
      libraryPath = "${pkgs.tree-sitter-grammars.tree-sitter-nu}/parser";
      extensions = [ "nu" ];
    };
  };
}
