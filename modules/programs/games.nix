#
# Gaming
# Steam + Lutris
#
# Do not forget to enable Steam play for all title in the settings menu
#

{ config, pkgs, lib, ... }:


{

  environment.systemPackages = with pkgs; [
    lutris
    steam
  ];

  programs = {                                  # Needed to succesfully start Steam
    steam = {
      enable = true;
      #remotePlay.openFirewall = true;          # Ports for Stream Remote Play
    };
    gamemode.enable = true;                     # Better gaming performance
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];                                            # Use Steam for Linux libraries
}