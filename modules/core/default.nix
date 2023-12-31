#
#  Core Modules
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ configuration.nix
#   └─ ./modules
#       └─ ./core
#           └─ default.nix *
#               └─ ...
#

[
  ./bootloader.nix
  ./flatpak.nix
  ./fonts.nix
  ./network.nix
  ./pipewire.nix
  ./printing.nix
  ./security.nix
  ./services.nix
  ./timezone.nix
  ./user.nix
  #./wayland.nix
  ./xserver.nix
  ./zram.nix
]