#
#  Hyprland configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./<host>
#   │       └─ default.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./hyprland
#               └─ default.nix *
#

{ config, lib, pkgs, host, system, hyprland, ... }:
let
  # exec = with host; if hostName == "work" then "exec nvidia-offload Hyprland" else "exec Hyprland"; # Starting Hyprland with nvidia (bit laggy so disabling)
  exec = "exec Hyprland";
in
{
  imports = 
  [(import ../../programs/waybar.nix )]
  ;

  environment = {
    #loginShellInit = ''
    #  if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
    #    ${exec}
    #  fi
    #'';                                   # Will automatically open Hyprland when logged into tty1

    variables = {
      #WLR_NO_HARDWARE_CURSORS="1";         # Possible variables needed in vm
      #WLR_RENDERER_ALLOW_SOFTWARE="1";
      XDG_CURRENT_DESKTOP="Hyprland";
      XDG_SESSION_TYPE="wayland";
      XDG_SESSION_DESKTOP="Hyprland";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      DISABLE_QT5_COMPAT = "0";
      GDK_BACKEND = "wayland";
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      WLR_DRM_NO_ATOMIC = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_STYLE_OVERRIDE = "kvantum";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";
      XDG_SESSION_TYPE = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
    };
    systemPackages = with pkgs; [
      grim
      mpvpaper
      slurp
      swappy
      swaylock
      wl-clipboard
      wlr-randr
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
    ];
  };

  programs = {
    hyprland = {
      enable = true;
    };
  };
  #xdg.portal = {
  #  enable = true;
  #  extraPortals = [
  #    pkgs.xdg-desktop-portal-hyprland
  #    # pkgs.xdg-desktop-portal-gtk
  #  ];
  #};

  #nixpkgs.overlays = [    # Waybar with experimental features
  #  (final: prev: {
  #    waybar = hyprland.packages.${system}.waybar-hyprland;
  #  })
  #];
}
