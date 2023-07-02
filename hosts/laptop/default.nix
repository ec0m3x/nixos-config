#
#  Specific system configuration settings for laptop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./laptop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       ├─ ./desktop
#       │   ├─ ./hyprland
#       │   │   └─ default.nix
#       │   └─ ./virtualisation
#       │       └─ default.nix
#       └─ ./hardware
#           └─ default.nix
#


{ config, pkgs, lib, user, ... }:

{
  imports =                                               # For now, if applying to other system, swap files
    [(import ./hardware-configuration.nix)] ++            # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    (import ../../modules/hardware) ++                    # Hardware modules
    [(import ../../modules/desktop/hyprland/default.nix)];   # Window Manager


  # Bootloader.
  boot = {                                  # Boot options
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.availableKernelModules = [ "amdgpu" ];

    loader = {                              # EFI Boot
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {                              # Most of grub is set up for dual boot
        enable = true;
        #version = 2;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;                 # Find all boot options
        configurationLimit = 10;
        enableCryptodisk = true;
      };
      timeout = 5;                          # Grub auto select time
    };
      kernelParams = [
        "tuxedo_keyboard.mode=0"
        "tuxedo_keyboard.brightness=255"
        "tuxedo_keyboard.color_left=0x00008B"
        "tuxedo_keyboard.color_center=0x00008B"
        "tuxedo_keyboard.color_right=0x00008B"
        ];
  };

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };


  # Enable networking
  networking.networkmanager.enable = true;
  systemd.services.ModemManager.enable = true;

  services = {
    tlp.enable = true;                      # TLP and auto-cpufreq for power management
    #logind.lidSwitch = "ignore";           # Laptop does not go to sleep when lid is closed
    auto-cpufreq.enable = true;
    blueman.enable = true;
  };


  # Scanner support
  hardware = {
    sane = {                                    # Used for scanning with Xsane
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
  };

  # Tuxedo specific
  #hardware.tuxedo-keyboard.enable = true;
  #hardware.tuxedo-control-center.enable = true;
  services.udev = {
    enable = true;
    extraRules = '' ACTION=="add|change", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="12d1", ATTR{idProduct}=="15bb", ATTR{bNumConfigurations}=="3", ATTR{bConfigurationValue}!="3" ATTR{bConfigurationValue}="3" '';
  };

  #temporary bluetooth fix
  systemd.tmpfiles.rules = [
    "d /var/lib/bluetooth 700 root root - -"
  ];
  systemd.targets."bluetooth".after = ["systemd-tmpfiles-setup.service"];

}
