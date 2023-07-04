#
#  Specific system configuration settings for gpu passthrough
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./desktop
#   │       └─ default.nix
#   └─ ./modules
#        └─ ./virtualisation
#            └─ gpu-passthrough.nix *
#

{ config, pkgs, user, ... }:

{

  boot.kernelParams = [ "amd_iommu=on" "pcie_aspm=off" ];  # load vfio modules

  boot.initrd.availableKernelModules = [ "vfio-pci" ];

  boot.initrd.preDeviceCommands = ''
    DEVS="0000:12:00.0 0000:12:00.1"
    for DEV in $DEVS; do
      echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    done
    modprobe -i vfio-pci
  '';

  boot.extraModprobeConfig = "options vfio-pci ids=1002:73ff,1002:ab28"; # grep PCI_ID /sys/bus/pci/devices/*/uevent


  environment.systemPackages = with pkgs; [               # install looking-glass
    looking-glass-client
  ];

  systemd.tmpfiles.rules = [                              # tmp files needed for looking-glass
    "f /dev/shm/looking-glass 0660 ${user} libvirtd -"
  ];



}