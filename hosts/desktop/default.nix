# Specific system configuration for desktop
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./desktop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       ├─ ./desktop
#       │   ├─ ./hyprland
#       │   │   └─ default.nix
#       │   └─ ./virtualisation
#       │       └─ default.nix
#       ├─ ./programs
#       │   └─ games.nix
#       └─ ./hardware
#           └─ default.nix


{ config, pkgs, lib, user, ... }:

{
  imports =                                               # For now, if applying to other system, swap files
    [(import ./hardware-configuration.nix)] ++            # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    [(import ../../modules/programs/games.nix)] ++        # Games
    [(import ../../modules/virtualisation/gpu-passthrough.nix)] ++        # GPU Pass
    [(import ../../modules/desktop/hyprland/default.nix)];   # Window Manager

  # Bootloader.
  boot = {                                  # Boot options
    kernelPackages = pkgs.linuxPackages_latest;

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
  };

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };


  # Enable networking
  networking.networkmanager.enable = true;


  # Dual gpu
  #services.switcherooControl.enable = true;

  hardware = {
    sane = {                                    # Used for scanning with Xsane
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
  };

  # Share home folder in local network
  #services.samba = {
  #  enable = true;
  #  shares = {
  #    share = {
  #      "path" = "home/${user}";
  #      "guest ok" = "yes";
  #      "read only" = "no";
  #    };
  #  };
  #};
}
