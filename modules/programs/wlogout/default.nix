{...}: {
  programs.wlogout = {
    enable = true;
    layout =
    [
      {
        "label" = "lock";
        "action" = "swaylock -fF --fade-in 2";
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
        "label" = "suspend";
        "action" = "systemctl suspend";
        "text" = "Standby";
        "keybind" = "e";
      }
    ];
  };
  home.file."$HOME/.config/wlogout/style.css".source = ./assets/style.css;
}
