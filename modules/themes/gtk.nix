{ pkgs
, ... 
}:{
    home.pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
      gtk.enable = true;
      #name = "Dracula-cursors";
      name = "Catppuccin-Mocha-Dark-Cursors";
      #package = pkgs.dracula-theme;
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 16;
    };

    gtk = {                                     # Theming
      enable = true;
      theme = {
        #name = "Dracula";
        name = "Catppuccin-Mocha-Compact-Mauve-Dark";
        #package = pkgs.dracula-theme;
        package = pkgs.catppuccin-gtk.override {
          accents = ["mauve"];
          size = "compact";
          variant = "mocha";
        };
      };
      iconTheme = {
        #name = "Papirus-Dark";
        name = "kora";
        #package = pkgs.papirus-icon-theme;
        package = pkgs.kora-icon-theme;
      };
      font = {
        #name = "JetBrains Mono Medium";
        name = "FiraCode Nerd Font Mono Medium";
      };                                        # Cursor is declared under home.pointerCursor
    };
}
