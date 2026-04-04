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
    rev = "c0db0889bab26b8af2c51ad19cc7ec25d2f9ae84";
    hash = "sha256-pZVBc4tmMXVRVZ83pmCNMO0/RzB6ehLsjWUcrVMDIoA=";
  };

  vendorHash = "sha256-vDt69hE7ZgAp1CdNSibRdpUvUpG575hOzfe7Sqs0RBY=";
  subPackages = [ "." ];
}
