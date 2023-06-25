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
    [(import ../../modules/desktop/gnome/default.nix)];   # Window Manager

  # Bootloader.
  boot = {                                  # Boot options
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {                              # EFI Boot
      systemd-boot.enable = true;
  	  efi.canTouchEfiVariables = true;
    };
  };
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "nixos-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;


  hardware = {
    sane = {                                    # Used for scanning with Xsane
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
  };

  # Tuxedo specific
  hardware.tuxedo-keyboard.enable = true;
  #hardware.tuxedo-control-center.enable = true;

}
