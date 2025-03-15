{ ... }:

{
  imports = [
    ./packages.nix
    ./shell.nix
    ./git.nix
  ];
  
  home.username = "nasuser";
  home.homeDirectory = "/home/nasuser";
  home.stateVersion = "24.11";
}
