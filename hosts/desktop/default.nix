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
  imports =                                                       # For now, if applying to other system, swap files
    [(import ./hardware-configuration.nix)]                       # Current system hardware config @ /etc/nixos/hardware-configuration.nix
  ++  [(import ../../modules/programs/games.nix)]                 # Games
  ++  [(import ../../modules/virtualisation/gpu-passthrough.nix)] #GPU Passthrough
  ++  [(import ../../modules/desktop/hyprland/default.nix)];      # Window Manager

  # Set hostname
  networking.hostName = "desktop";

  # Dual gpu
  #services.switcherooControl.enable = true;

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
