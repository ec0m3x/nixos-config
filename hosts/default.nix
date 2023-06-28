#
#  These are the different profiles that can be used when building NixOS.
#
#  flake.nix 
#   └─ ./hosts  
#       ├─ default.nix *
#       ├─ configuration.nix
#       ├─ home.nix
#       └─ ./desktop OR ./laptop
#            ├─ ./default.nix
#            └─ ./home.nix 
#

{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, user, hyprland, location, ... }:

let
  system = "x86_64-linux";                                  # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };


  lib = nixpkgs.lib;
in

{
    desktop = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs unstable system user hyprland location;
          host = {
            hostName = "desktop";
          };
        };
        modules = [
            hyprland.nixosModules.default
            ./desktop
            ./configuration.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit unstable user; };
              home-manager.users.${user} = {
                imports = [(import ./home.nix)] ++ [(import ./desktop/home.nix)];
              };
            }
        ];
    };

    laptop = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs unstable system user hyprland location;
          host = {
            hostName = "laptop";
          };
        };  
        modules = [
            hyprland.nixosModules.default
            ./laptop
            ./configuration.nix
            
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit unstable user; };
              home-manager.users.${user} = {
                imports = [(import ./home.nix)] ++ [(import ./laptop/home.nix)];
              };
            }
        ];
    };
}