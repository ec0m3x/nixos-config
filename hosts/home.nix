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
    (import ../modules/programs);


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
      
      # Cloud-sync
      nextcloud-client

      # Apps
      bitwarden      
      onlyoffice-bin
      libreoffice-fresh
      firefox
      google-chrome
      appimage-run
      webex
      discord
      obsidian
      zotero
      
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
    file.".config/wall".source = ../modules/themes/wall;
    file.".config/wall.mp4".source = ../modules/themes/wall.mp4;
    pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
      gtk.enable = true;
      name = "Dracula-cursors";
      #name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.dracula-theme;
      #package = pkgs.catppuccin-cursors.mochaDark;
      size = 16;
  };

  programs = {
    home-manager.enable = true;
    vscode = {
      enable = true;
      enableUpdateCheck = true;
      extensions = with pkgs.vscode-extensions; [
        james-yu.latex-workshop
        #gitlab.gitlab-workflow
        bbenoist.nix
      ];
    };
    git = {
      enable = true;
      userName = "${user}";
      userEmail = "seb.koch@yahoo.de";
      #includes = [{ path = "~/.gitconfig.local"; }];
    };
    gh = {
      enable = true;
      enableGitCredentialHelper = true;
      settings = {
        prompt = "enabled";
        git_protocol = "https";
      };
    };
    yt-dlp = {
      enable = true;
    };
  };

  services = {                            # Applets
    nextcloud-client = {                  # Nextcloud
        enable = true;
        startInBackground = true;                    
    };
  };

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Dracula";
      #name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = pkgs.dracula-theme;
      #package = pkgs.catppuccin-gtk.override {
      #  accents = ["mauve"];
      #  size = "compact";
      #  variant = "mocha";
      #};
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      #name = "JetBrains Mono Medium";
      name = "FiraCode Nerd Font Mono Medium";
    };                                        # Cursor is declared under home.pointerCursor
  };

  systemd.user.targets.tray = {               # Tray.target can not be found when xsession is not enabled. This fixes the issue.
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
