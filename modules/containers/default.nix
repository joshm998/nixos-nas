# modules/containers/default.nix
{ ... }:

{
  imports = [
    ./codeserver.nix
  ];
  virtualisation.oci-containers.backend = "docker";
}

