{...}: {
  programs.wlogout = {
    enable = true;
    layout =
    [
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
