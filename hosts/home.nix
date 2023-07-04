#
#  General Home-manager configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix *
#   └─ ./modules
#       ├─ ./programs
#       │   └─ default.nix
#       └─ ./services
#           └─ default.nix
#

{ config, lib, pkgs, user, ... }:

{

  imports =                                   # Home Manager Modules
      (import ../modules/programs)
  ++  (import ../modules/services)
  ++  [(import ../modules/themes/gtk.nix)]
  ;


  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "23.05";

    packages = with pkgs; [
      # Terminal
      btop
      ranger
      nitch

      # Video/Audio
      feh               # Image Viewer
      mpv               # Media Player
      pavucontrol       # Audio Control
      vlc               # Media Player
      yt-dlp            # Youtube downloader
      
      # Mail
      thunderbird
      
      # Cloud-sync
      nextcloud-client

      # Apps
      bitwarden      
      onlyoffice-bin
      libreoffice-fresh
      appimage-run
      webex
      discord
      webcord
      obsidian
      zotero
      obs-studio
      
      # LaTex
      texlive.combined.scheme-full

      # File management
      gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      pcmanfm           # File Manager
      p7zip
      rsync
      unzip
      unrar
      zip

      # Development
      android-studio
      jetbrains.pycharm-professional
      vscode
    ];


    file.".config/wall".source = ../modules/themes/wallpaper/wall3.jpg;
    file.".config/wall.mp4".source = ../modules/themes/wallpaper/an_wall1.mp4;

  };  

  programs.home-manager.enable = true;  #Enable Home-manager

}
