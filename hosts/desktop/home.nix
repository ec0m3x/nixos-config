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
      ffmpeg            # Video Support
      gimp              # Graphical Editor
      inkscape          # Vector Graphical Editor
      brave         
    ];
  };
}