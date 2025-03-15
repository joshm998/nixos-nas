{ ... }:

{
  imports = [
    ./docker.nix
    ./ssh.nix
    ./samba.nix
    ./homepage.nix
    ./cockpit.nix
  ];
}
