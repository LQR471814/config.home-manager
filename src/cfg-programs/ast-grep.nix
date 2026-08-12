{ pkgs, ... }:
{
  customLanguages = {
    nu = {
      libraryPath = "${pkgs.tree-sitter-grammars.tree-sitter-nu}/parser";
      extensions = [ "nu" ];
    };
    markdown = {
      libraryPath = "${pkgs.tree-sitter-grammars.tree-sitter-markdown}/parser";
      extensions = [ "md" ];
    };
    markdown_inline = {
      libraryPath = "${pkgs.tree-sitter-grammars.tree-sitter-markdown-inline}/parser";
      extensions = [ "md" ];
    };
  };
}
