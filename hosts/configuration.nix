
{ config, pkgs, lib, inputs, user,  ... }:

{
  imports = 
    (import ../modules/shell) ++
    (import ../modules/virtualisation);


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

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";                          # or us/azerty/etc
  };

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
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.enableAllFirmware = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" "scanner" "libvirtd" "adbusers"];
  };

  # Shell enviroment
  #programs.zsh.enable = true;   # not needed
  environment.shells = with pkgs; [ zsh ];

  # Install Fonts
  fonts.fonts = with pkgs; [                # Fonts
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # Icons
    corefonts                               # MS
    (nerdfonts.override {                   # Nerdfont Icons override
      fonts = [
        "FiraCode"
      ];
    })
  ];

  # Enable zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    #memoryMax = 20;
    memoryPercent = 20;
  };

  environment = {
    variables = {
      TERMINAL = "alacritty";
    };
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
  ];

  # Enable flatpaks
  services.flatpak.enable = true;

  # Enable ADB
  programs.adb.enable = true;

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
    package = pkgs.nixVersions.unstable;    # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;        # Allow proprietary software.



  system.stateVersion = "23.05";


}
