{
  final,
  prev,

  nodejs_24,

  lib,

  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage {
  pname = "markdowndb";
  version = "0.9.5";

  src = fetchFromGitHub {
    owner = "flowershow";
    repo = "markdowndb";
    tag = "v0.9.5";
    hash = "sha256-wbohyFj4tUTVWVS8sU9oBIqRzm0mLnaCdMnLONIzK5g=";
  };

  nodejs = nodejs_24;

  npmDepsHash = "sha256-Q+e797P0m6nup1C43+VMcYSfDehDaT1Kwr3tztjCGtU=";

  meta = {
    description = "Parse markdown files and store them in an SQL database";
    license = lib.licenses.mit;
    mainProgram = "mddb";
  };
}
