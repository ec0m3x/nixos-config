#
#  Apps
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix
#   └─ ./modules
#       └─ ./apps
#           └─ default.nix *
#               └─ ...
#

[
  ./alacritty.nix
  ./rofi.nix
  ./wofi.nix
  ./chromium.nix
  ./firefox.nix
  ./git.nix
  #./waybar.nix
  #./games.nix
]

# Games.nix is pulled from desktop/default.nix
# waybar.nix is pulled from modules/desktop/hyprland/default.nix