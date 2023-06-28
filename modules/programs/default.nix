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
  #./waybar.nix
  #./games.nix
]

# Games.nix is pulled from desktop/default.nix