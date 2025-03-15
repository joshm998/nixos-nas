{ config, lib, pkgs, ... }:

# Need to run smbpasswd to set password for samba users

{
  # Create the samba group
  users.groups.samba = {};
  
  # Create a samba user with proper permissions (non-login)
  users.users.sambauser = {
    isNormalUser = false;      # Not a normal user, can't login
    isSystemUser = true;       # System user
    home = "/var/empty";       # No real home directory needed
    createHome = false;        # Don't create home directory
    description = "Samba User";
    group = "samba";           # Primary group
    shell = pkgs.shadow;       # Assign /bin/nologin as shell
  };
  
  # Create share directories and set proper permissions
  systemd.tmpfiles.rules = [
    "d /mnt/storage/public 0755 sambauser samba - -"
    "d /mnt/storage/private 0755 sambauser samba - -"
    "d /mnt/storage/timemachine 0755 sambauser samba - -"    
  ];
  
  # Install necessary packages
  environment.systemPackages = with pkgs; [
    samba
    cifs-utils
  ];
  
  # Configure Samba service
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    
    settings = {
      global = {
        "workgroup" = "workgroup";
        "server string" = "nixos samba server";
        "netbios name" = "nixsamba";
        "security" = "user";
        "hosts allow" = "192.168.1. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
        
        # Mac optimization settings
        "min protocol" = "SMB2";
        "vfs objects" = "fruit streams_xattr";
        "fruit:aapl" = "yes";
        "fruit:nfs_aces" = "no";
        "fruit:model" = "MacSamba";
        "fruit:metadata" = "stream";
        "fruit:resource" = "stream";
        "fruit:veto_appledouble" = "no";
        "fruit:posix_rename" = "yes";
        "fruit:zero_file_id" = "yes";
        "fruit:wipe_intentionally_left_blank_rfork" = "yes";
        "fruit:delete_empty_adfiles" = "yes";
      };
      
      "public" = {
        "path" = "/mnt/storage/public";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "sambauser";
        "force group" = "samba";
        
        # Mac compatibility settings
        "fruit:time machine" = "no";
        "spotlight" = "yes";
      };
      
      "private" = {
        "path" = "/mnt/storage/private";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "sambauser";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "sambauser";
        "force group" = "samba";
        
        # Mac compatibility settings
        "fruit:time machine" = "no";
        "spotlight" = "yes";
      };
      
      "timemachine" = {
        "path" = "/mnt/storage/timemachine";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "sambauser";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "sambauser";
        "force group" = "samba";
        
        # Time Machine specific settings
        "fruit:time machine" = "yes";
        "fruit:time machine max size" = "500G";
        "vfs objects" = "catia fruit streams_xattr";
      };
    };
  };

 services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
