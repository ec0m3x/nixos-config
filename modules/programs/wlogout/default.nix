{...}: {
  programs.wlogout = {
    enable = true;
    layout =
    [
      {
        "label" = "lock";
        "action" = "swaylock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "reboot";
        "action" = "systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
      {
        "label" = "shutdown";
        "action" = "poweroff";
        "text" = "Shut Down";
        "keybind" = "s";
      }
      {
        "label" = "logout";
        "action" = "loginctl terminate-user $USER";
        "text" = "Logout";
        "keybind" = "e";
      }
    ];
    #
  };
  home.file."$HOME/.config/wlogout/style.css".source = ./assets/style.css;
  #xdg.configFile."wlogout".source = ./config;
}
