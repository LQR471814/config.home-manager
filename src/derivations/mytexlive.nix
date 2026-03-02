{
  final,
  prev,

  texlive,
}:
texlive.combine {
  inherit (texlive)
    scheme-basic
    collection-latexrecommended
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
    hyperref
    setspace
    texcount
    fontspec
    ctex
    xecjk
    enumitem
    moderncv
    latexindent
    times
    ;
}
