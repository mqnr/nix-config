{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "cryptd" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd.systemd.enable = true;

  fileSystems =
    let
      btrfsOptions = [
        "compress=zstd"
        "noatime"
      ];

      mkBtrfsSubvol = device: subvol: additionalOptions: {
        inherit device;
        fsType = "btrfs";
        options = [ "subvol=${subvol}" ] ++ additionalOptions;
      };
      mkBtrfsSubvolRoot = mkBtrfsSubvol "/dev/disk/by-label/NIXOS_ROOT";
      mkBtrfsSubvolData = mkBtrfsSubvol "/dev/disk/by-label/NIXOS_DATA";
    in
    {
      "/" = mkBtrfsSubvolRoot "@root" btrfsOptions;
      "/home" = mkBtrfsSubvolRoot "@home" btrfsOptions;
      "/nix" = mkBtrfsSubvolRoot "@nix" (btrfsOptions ++ [ "nodev" ]);
      "/var/log" = mkBtrfsSubvolRoot "@log" btrfsOptions;
      "/swap" = mkBtrfsSubvolRoot "@swap" [ "noatime" ];

      "/data" = mkBtrfsSubvolData "@data" btrfsOptions;

      "/boot" = {
        device = "/dev/disk/by-label/NIXOS_BOOT";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };
    };

  boot.initrd.luks.devices = {
    cryptroot = {
      device = "/dev/disk/by-partlabel/NIXOS_LUKS";
      allowDiscards = true;
    };
    cryptdata = {
      device = "/dev/disk/by-partlabel/DATA_LUKS";
      keyFile = "/etc/keys/data.key";
    };
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 8 * 1024;
    }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
