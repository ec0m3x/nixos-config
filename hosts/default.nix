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

{ lib, inputs, system, home-manager, user, location, ... }:

{
    desktop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit user inputs; };
        modules = [
            ./desktop
            ./configuration.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit user; };
              home-manager.users.${user} = {
                imports = [(import ./home.nix)] ++ [(import ./desktop/home.nix)];
              };
            }
        ];
    };

    laptop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit user inputs; };
        modules = [
            ./laptop
            ./configuration.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit user; };
              home-manager.users.${user} = {
                imports = [(import ./home.nix)] ++ [(import ./laptop/home.nix)];
              };
            }
        ];
    };
}