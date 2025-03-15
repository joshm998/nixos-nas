# snapraid-mergerfs.nix
{ config, pkgs, lib, ... }:

{
  # Install necessary packages
  environment.systemPackages = with pkgs; [
    snapraid
    mergerfs
    parted
    smartmontools
    hdparm
  ];

  # Mount the three drives
  fileSystems = {
    "/mnt/disk1" = {
      device = "/dev/sda";
      fsType = "ext4";
      options = [ "defaults" "nofail" "x-systemd.device-timeout=30" ];
    };
    
    "/mnt/disk2" = {
      device = "/dev/sdb";
      fsType = "ext4";
      options = [ "defaults" "nofail" "x-systemd.device-timeout=30" ];
    };
    
    "/mnt/disk3" = {
      device = "/dev/nvme0n1";
      fsType = "ext4";
      options = [ "defaults" "nofail" "x-systemd.device-timeout=30" ];
    };
    
    # MergerFS pool
    "/mnt/storage" = {
      device = "/mnt/disk1:/mnt/disk2:/mnt/disk3";
      fsType = "fuse.mergerfs";
      options = [
        "defaults"
        "allow_other"
        "use_ino"
        "cache.files=partial"
        "dropcacheonclose=true"
        "category.create=mfs"  # Most Free Space for new files
        "moveonenospc=true"    # Move to another drive when no space
        "minfreespace=20G"     # Minimum free space threshold
      ];
    };
  };

  # Create snapraid configuration
  environment.etc."snapraid.conf".text = ''
    # Parity file (using disk3 for parity)
    parity /mnt/disk3/snapraid.parity

    # Content file (metadata)
    content /var/snapraid/snapraid.content
    content /mnt/disk1/snapraid.content
    content /mnt/disk2/snapraid.content

    # Data disks
    data d1 /mnt/disk1/
    data d2 /mnt/disk2/

    # Excludes
    exclude *.bak
    exclude *.tmp
    exclude .Trash-*
    exclude /tmp/
    exclude /lost+found/
    exclude .snapshots/
  '';

  # Create directory for snapraid content files
  system.activationScripts.snapraid-dirs = ''
    mkdir -p /var/snapraid
  '';

  # Regular snapraid sync service
  systemd.services.snapraid-sync = {
    description = "SnapRAID Sync";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.snapraid}/bin/snapraid sync";
      User = "root";
    };
  };

  # Schedule regular snapraid sync
  systemd.timers.snapraid-sync = {
    description = "Timer for SnapRAID Sync";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  # Optional: snapraid scrub to check for bit rot
  systemd.services.snapraid-scrub = {
    description = "SnapRAID Scrub";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.snapraid}/bin/snapraid scrub";
      User = "root";
    };
  };

  # Schedule regular snapraid scrub (monthly)
  systemd.timers.snapraid-scrub = {
    description = "Timer for SnapRAID Scrub";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "monthly";
      Persistent = true;
    };
  };
}
