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


  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "23.05";

    packages = with pkgs; [
      # Terminal
      btop
      ranger
      nitch
      
      # Cloud-sync
      nextcloud-client

      # Apps
      bitwarden      
      onlyoffice-bin
      libreoffice-fresh
      firefox
      google-chrome
      appimage-run
      
      # File management
      p7zip
      rsync
      unzip
      unrar
      zip

      # Development
      android-studio
      jetbrains.pycharm-professional
      vscode

      # Gnome extensions
      gnomeExtensions.appindicator 
    ]; 
  };

  programs = {
    vscode = {
      enable = true;
      enableUpdateCheck = true;
      extensions = with pkgs.vscode-extensions; [
        james-yu.latex-workshop
        gitlab.gitlab-workflow
      ];
    };
    git = {
      enable = true;
      userName = "${user}";
      userEmail = "me@example.com";
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
  };

  services = {                            # Applets
    nextcloud-client = {                  # Nextcloud
        enable = true;
        startInBackground = true;                    
    };
  };
}
