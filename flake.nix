#
#  flake.nix *             
#   ├─ ./hosts
#   │   └─ default.nix
#


{
  description = "My personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; 

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, ... }: 
    let
      system = "x86_64-linux";
      user = "ec0m3x";
      location = "$HOME/.setup";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;

    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit nixpkgs nixpkgs-unstable inputs user system home-manager location;
        }
      );
    }; 
}
