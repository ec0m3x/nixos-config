{ pkgs
, ...
, user
}:{
  services.xserver = {
    enable = true;
    layout = "de";
    videoDrivers = [ "amdgpu" ];
    displayManager.autoLogin = {
      enable = true;
      user = "${user}";
    };
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
    };
  };
}