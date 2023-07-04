{ inputs, pkgs, ... }:
{
  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      # pkgs.xdg-desktop-portal-gtk
    ];
  };
}
