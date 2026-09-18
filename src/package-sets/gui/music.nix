{
  pkgs ? import <nixpkgs> { },
  fix-pw,
  ...
}:
let
  inherit (pkgs)
    ardour
    musescore
    easyeffects
    linvstmanager
    pwvucontrol
    qpwgraph
    lsp-plugins
    x42-plugins
    geonkick
    drumgizmo
    x42-avldrums
    aether-lv2
    airwindows-lv2
    bankstown-lv2
    bolliedelayxt-lv2
    bs2b-lv2
    guitarix-vst
    sfizz-ui
    decent-sampler
    x42-gmsynth
    vital
    dexed
    odin2
    surge-xt
    mda_lv2
    ;
in
[
  # ardour crashes on changing pipewire quantum, we launch with fixed quantum
  # (ardour tracker #10193)
  (ardour.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
      pkgs.makeWrapper
    ];
    postFixup = (old.postFixup or "") + ''
      wrapProgram $out/bin/ardour9 \
        --set PIPEWIRE_QUANTUM "256/48000"
    '';
  }))

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
