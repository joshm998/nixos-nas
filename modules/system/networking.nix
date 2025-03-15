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
    
  # Configure firewall
  firewall = {
    allowPing = true;
    # Add Samba ports to firewall if not handled by openFirewall
    allowedTCPPorts = [ 8080 22 139 445 8082 ];
    allowedUDPPorts = [ 137 138 ];
    # Special command for NetBIOS name service helper
    extraCommands = ''
      iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns
    '';
  };
  };
}
