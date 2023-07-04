{ pkgs
, inputs
, ...
}:{

  users.users.${user} = {
    isNormalUser = true;
    description = "3c0m3x";
    email = "skoch@sks-concept.de";
    initialPassword = "geheim";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" "scanner" "libvirtd" "adbusers"];
  };
  nix.settings.allowed-users = [ "${user}" ];
}
