{
  final,
  prev,

  busybox,
  cross-stream,
}:

derivation {
  name = "nu-xs";
  system = builtins.currentSystem;
  builder = "${busybox}/bin/sh";
  args = [
    "-c"
    ''
      ${busybox}/bin/mkdir -p $out
      ${cross-stream}/bin/xs nu > $out/xs.nu 
    ''
  ];
}
