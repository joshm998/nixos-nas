{ config, pkgs, lib, ... }:

{
  # Basic system configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Set your time zone
  time.timeZone = "Australia/Adelaide";
  
  # System packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    htop
    gh
  ];
  
  # Shell aliases
  programs.bash.shellAliases = {
    dps = "docker ps";
  };
  
  # System optimization
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
