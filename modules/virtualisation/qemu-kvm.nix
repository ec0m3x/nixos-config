{ config, pkgs, ... }:

{

  # Install necessary packages
  environment = {
    systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      qemu
      OVMF
      gvfs                                    # Used for shared folders between Linux and Windows
    ];
  };

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;                          # Virtual drivers
      #qemuPackage = pkgs.qemu_kvm;           # Default
      qemu = {
        verbatimConfig = ''
         nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
        '';
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;        # USB passthrough
  };
}