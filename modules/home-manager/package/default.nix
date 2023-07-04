{ inputs
, pkgs
, ...
}: {
  home.packages =
    let
      php = pkgs.php.buildEnv { extraConfig = "memory_limit = 2G"; };
    in
    (with pkgs;
    [
      # programming
      python39
      nix-prefetch-github
      vscode
      android-studio
      jetbrains.pycharm-professional

      # Terminal
      btop
      ranger
      nitch

      # Video/Audio
      feh               # Image Viewer
      mpv               # Media Player
      pavucontrol       # Audio Control
      vlc
      playerctl

      # Mail
      thunderbird

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

      #others
      libnotify
      gparted
      xdg-utils

    ]);
}
