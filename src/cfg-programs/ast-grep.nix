{ pkgs, ... }:
let
  cfg = {
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
  };
  src = (pkgs.formats.yaml { }).generate "config.yaml" cfg;
in
{
  home.file."sgconfig.yaml".source = "${src}";
}
