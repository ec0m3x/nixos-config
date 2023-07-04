{ ... }: {
  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
  };
}
