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
  boot.kernelModules = [ "kvm-amd" ];

  boot.initrd.availableKernelModules = [ "amdgpu" "vfio-pci" ];


  environment.systemPackages = with pkgs; [               # install looking-glass
    looking-glass-client
  ];

  systemd.tmpfiles.rules = [                              # tmp files needed for looking-glass
    "f /dev/shm/looking-glass 0660 ${user} qemu-libvirtd -"
  ];



}