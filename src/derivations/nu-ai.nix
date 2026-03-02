{
  final,
  prev,

  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  name = "nu-ai";
  system = "x86_64-linux";

  src = fetchFromGitHub {
    owner = "fj0r";
    repo = "ai.nu";
    rev = "8e73f99daac10d161e42160622293d532eb2f62e";
    hash = "sha256-4W31M7iSe0UwI5qeL3bpjSAzSlta4l5bY0jGLlWF9gM=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    cp -r $src/ai $out/ai.nu
  '';
}
