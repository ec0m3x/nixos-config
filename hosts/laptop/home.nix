#
#  Home-manager configuration for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./desktop
#   │       └─ ./home.nix
#

{ pkgs, ... }:

{
  imports =
    [
      ../../modules/desktop/hyprland/home.nix  # Window Manager
    ];

  home = {                                # Specific packages for desktop
    packages = with pkgs; [    
      # Imported in default or from modules
      #discord          # Comms           # See overlay default.nix
      ffmpeg           # Video Support
      gimp              # Graphical Editor
      cava
      #inkscape         # Vector Graphical Editor
      #tlp               # Power management
    ];
  };


#  services = {                            # Applets
#    blueman-applet.enable = true;         # Bluetooth
#   cbatticon = {
#     enable = true;
#     criticalLevelPercent = 10;
#     lowLevelPercent = 20;
#     iconType = null;
#   };
#  };
}