#
#  Hardware
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./<host>
#   │       └─ default.nix
#   └─ ./modules
#       └─ ./laptop
#           └─ default.nix *
#               └─ ...
#
[
  ./batterysave.nix
  ./bluetooth.nix
  ./tuxedo.nix
]