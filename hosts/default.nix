{ inputs
, nixpkgs
, self
, ...
}:

let
  # System architecture
  system = "x86_64-linux";
  # Allow unfree software
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;

in
{
    # Config for desktop
    desktop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit self inputs; };
      modules = 
      [ (import ../modules/nixos/bootloader.nix) ]
      ++ [ (import ../modules/nixos/hardware.nix) ]
      ++ [ (import ../modules/nixos/xserver.nix) ]
      ++ [ (import ../modules/nixos/steam.nix) ]
      ++ [ (import ../modules/nixos/network-desktop.nix) ]
      ++ [ (import ../modules/nixos/pipewire.nix) ]
      ++ [ (import ../modules/nixos/program.nix) ]
      ++ [ (import ../modules/nixos/printing.nix)]
      ++ [ (import ../modules/nixos/security.nix) ]
      ++ [ (import ../modules/nixos/services.nix) ]
      ++ [ (import ../modules/nixos/system.nix) ]
      ++ [ (import ../modules/nixos/user.nix) ]
      ++ [ (import ../modules/nixos/wayland.nix) ]
      ++ [ (import ../modules/nixos/virtualization.nix) ]
      ++ [ (import ./desktop/hardware-configuration.nix) ]
    ;
  };
    # Config for laptop
    laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit self inputs; };
      modules = 
      [ (import ../modules/nixos/bootloader.nix) ]
      ++ [ (import ../modules/nixos/hardware.nix) ]
      ++ [ (import ../modules/nixos/bluetooth.nix) ]
      ++ [ (import ../modules/nixos/xserver.nix) ]
      #++ [ (import ../modules/nixos/steam.nix) ]
      ++ [ (import ../modules/nixos/network-laptop.nix) ]
      ++ [ (import ../modules/nixos/pipewire.nix) ]
      ++ [ (import ../modules/nixos/program.nix) ]
      ++ [ (import ../modules/nixos/printing.nix)]
      ++ [ (import ../modules/nixos/security.nix) ]
      ++ [ (import ../modules/nixos/services.nix) ]
      ++ [ (import ../modules/nixos/battery.nix) ]
      ++ [ (import ../modules/nixos/tuxedo.nix) ]
      ++ [ (import ../modules/nixos/system.nix) ]
      ++ [ (import ../modules/nixos/user.nix) ]
      ++ [ (import ../modules/nixos/wayland.nix) ]
      ++ [ (import ../modules/nixos/virtualization.nix) ]
      ++ [ (import ./laptop/hardware-configuration.nix) ]
    ;
  };
}