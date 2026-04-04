{
  final,
  prev,

  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  name = "nu-plugin-caldav";
  system = builtins.currentSystem;

  src = fetchFromGitHub {
    owner = "lqr471814";
    repo = "nu_plugin_caldav";
    rev = "f978c63d44f320cafbd14e3b547f1f5c5389e463";
    hash = "sha256-OlzTEOVoZ+rpjL/l0HkbExJXqrH+ZfYRqZbOZMq0uIk=";
  };

  vendorHash = "sha256-vDt69hE7ZgAp1CdNSibRdpUvUpG575hOzfe7Sqs0RBY=";
  subPackages = [ "." ];
}
