{
  pkgs ? import <nixpkgs> { },
  fix-pw,
  ...
}:
with pkgs;
[
  ardour
  (fix-pw musescore)
  (fix-pw easyeffects)

  linvstmanager
  pwvucontrol # audio patcher
  qpwgraph

  # analyzers
  lsp-plugins
  x42-plugins

  # drums
  geonkick
  drumgizmo
  x42-avldrums

  # effects
  aether-lv2
  airwindows-lv2
  bankstown-lv2
  bolliedelayxt-lv2
  bs2b-lv2
  guitarix-vst

  # samplers
  sfizz-ui
  decent-sampler

  # synthesizers
  x42-gmsynth
  vital
  dexed
  odin2
  surge-xt

  # instruments
  mda_lv2
]
