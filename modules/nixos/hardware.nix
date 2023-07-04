{ pkgs, ... }: {
  # hardware.video.hidpi.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
  #powerManagement.cpuFreqGovernor = "performance";

  # Enable zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    #memoryMax = 20;
    memoryPercent = 20;
  };
  # Used for scanning with Xsane
  hardware.sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
}
