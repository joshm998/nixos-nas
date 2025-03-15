{ config, pkgs, ... }:

{
  # Define a user account
  users.users.nasuser = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    initialPassword = "changeme"; # Remember to change this after setup!
  };
}
