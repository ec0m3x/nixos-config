{ pkgs, ... }:

{

  # Bootloader
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];
    loader = {                              # EFI Boot
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        #version = 2;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;                 # Find all boot options
        configurationLimit = 10;
        enableCryptodisk = true;
      };
      timeout = 5;                          # Grub auto select time
    };
  };

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
}
