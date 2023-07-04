{ pkgs, ... }:
{
    services.udev = {
    enable = true;
    extraRules = '' ACTION=="add|change", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="12d1", ATTR{idProduct}=="15bb", ATTR{bNumConfigurations}=="3", ATTR{bConfigurationValue}!="3" ATTR{bConfigurationValue}="3" '';
    };
    #hardware.tuxedo-keyboard.enable = true;
    #hardware.tuxedo-control-center.enable = true;
}