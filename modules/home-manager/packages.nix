{ pkgs, ... }:

{
  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    btop
    ncdu
    iotop
    duf
    tmux
  ];
}
