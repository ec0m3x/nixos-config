
{ config, pkgs, lib, inputs, user,  ... }:

{
  imports = 
      (import ../modules/shell) 
  ++  (import ../modules/virtualisation)
  ++  (import ../modules/core)
  ;

  environment = {
    variables = {
      TERMINAL = "alacritty";
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    python3
    git
    wget
    killall
    pciutils
    usbutils
  ];

  # Nix settings
  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.unstable;    # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;        # Allow proprietary software.

  system.stateVersion = "23.05";


}
