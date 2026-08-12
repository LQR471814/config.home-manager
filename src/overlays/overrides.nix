final: prev: {
  kitty-themes = prev.kitty-themes.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
      prev.jq
    ];
    postInstall = (old.postInstall or "") + ''
      ${prev.jq}/bin/jq -c '. + [
        {
          author: "thesimonho",
          blurb: "🌊 Remixed Kanagawa colourschemes with muted colors. For Neovim.",
          "file": "themes/Kanagawa-Paper-Ink.conf",
          "license": "MIT",
          "name": "Kanagawa Paper Ink",
          "num_settings": 30,
          "upstream": "https://github.com/thesimonho/kanagawa-paper.nvim/raw/main/extras/kitty/kanagawa-paper-ink.conf"
        }
      ]' $out/share/kitty-themes/themes.json > $out/share/kitty-themes/themes.json

      cp ${../Kanagawa-Paper-Ink.conf} $out/share/kitty-themes/themes/Kanagawa-Paper-Ink.conf
    '';
  });

  tree-sitter-grammars = prev.tree-sitter-grammars // {
    tree-sitter-markdown = prev.tree-sitter-grammars.tree-sitter-markdown.overrideAttrs (old: {
      env = (old.env or { }) // {
        EXTENSION_WIKI_LINK = "1";
      };
    });
  };
}
