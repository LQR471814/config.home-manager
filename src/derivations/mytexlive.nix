{
  final,
  prev,

  texlive,
  myconfig,
}:
texlive.combine {
  inherit (texlive)
    scheme-medium
    latexmk
    pdftex
    svg
    transparent
    pgfplots
    catchfile
    titlesec
    dvipng
    standalone
    varwidth
    preview
    cm-super
    biber
    biblatex
    biblatex-apa
    biblatex-mla
    biblatex-ieee
    hyperref
    setspace
    texcount
    fontspec
    ctex
    xecjk
    enumitem
    latexindent
    times
    datetime2
    datetime2-english
    csvsimple
    ;
  myconfig = {
    pkgs = [ myconfig ];
    tlType = "run";
  };
}
