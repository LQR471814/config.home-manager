{ IS_DESKTOP, pkgs, ... }:
{
  enable = false;
  package = if IS_DESKTOP then pkgs.ollama-cuda else pkgs.ollama;
  acceleration = if IS_DESKTOP then "cuda" else null;
}
