{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
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
