{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    layout = "de";
    videoDrivers = [ "amdgpu" ];
    displayManager.autoLogin = {
      enable = true;
      user = "ec0m3x";
    };
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
    };
  };
}
