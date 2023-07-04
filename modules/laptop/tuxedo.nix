#
# Tuxedo Aura 15 custom config
#

{ pkgs, ... }:

{
  boot.kernelParams = [
    "tuxedo_keyboard.mode=0"
    "tuxedo_keyboard.brightness=255"
    "tuxedo_keyboard.color_left=0x00008B"
    "tuxedo_keyboard.color_center=0x00008B"
    "tuxedo_keyboard.color_right=0x00008B"
  ];
  services.udev = {
    enable = true;
    extraRules = '' ACTION=="add|change", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="12d1", ATTR{idProduct}=="15bb", ATTR{bNumConfigurations}=="3", ATTR{bConfigurationValue}!="3" ATTR{bConfigurationValue}="3" '';
  };
  
  hardware.tuxedo-keyboard.enable = true;

}