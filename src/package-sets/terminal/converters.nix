{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    pdf2svg
    ffmpeg
    imagemagick
    librsvg
    pandoc
    unrar
    zip
    ;
in
[
  pdf2svg
  ffmpeg
  imagemagick
  librsvg
  pandoc
  # sc-im
  # qpdf
  # openrefine

  unrar
  zip
]
