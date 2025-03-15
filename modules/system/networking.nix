{ config, pkgs, ... }:

{
  networking = {
    hostName = "nas";
    networkmanager.enable = true;
    
    # Add static IP if needed
    # interfaces.eno1.ipv4.addresses = [{
    #   address = "192.168.1.100";
    #   prefixLength = 24;
    # }];
    # defaultGateway = "192.168.1.1";
    # nameservers = [ "1.1.1.1" "8.8.8.8" ];
    
    firewall.allowedTCPPorts = [ 8080 22 ];
  };
}
