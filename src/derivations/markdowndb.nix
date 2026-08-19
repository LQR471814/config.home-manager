{
  nodejs_20,

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
  };

  nodejs = nodejs_20;

  npmDepsHash = "";

  meta = {
    description = "Parse markdown files and store them in an SQL database";
    license = lib.licenses.mit;
    mainProgram = "mddb";
  };
}
