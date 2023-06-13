
{ config, pkgs, lib, inputs, user,  ... }:

{
  imports = (import ../modules/shell);

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable printing
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
  };    

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "3c0m3x";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" "scanner" "libvirtd" ];
  };

  # Shell enviroment
  #programs.zsh.enable = true;   # not needed
  environment.shells = with pkgs; [ zsh ];

  # Install Fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    font-awesome
    (nerdfonts.override { fonts = [ "DroidSansMono" "FiraCode" "Hack" ]; })
  ];

  # Enable zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    #memoryMax = 20;
    memoryPercent = 20;
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vim 
  python3
  git
  wget
  killall
  texlive.combined.scheme-full
  pciutils
  usbutils
  virt-manager
  discord
  ];

  # Enable flatpaks
  services.flatpak.enable = true;


  # Auto upgrade
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-23.05";
    dates = "daily";
  };

  # Nix settings
  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  package = pkgs.nixFlakes;
  extraOptions = ''
    experimental-features = nix-command flakes
    warn-dirty = false
  '';  
  };

  nixpkgs.config.allowUnfree = true;        # Allow proprietary software.

  ## Enable Virtualisation and libvirtd
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;


  system.stateVersion = "23.05";


}
