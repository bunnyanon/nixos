{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  networking = {
    hostName = "bridget";
    
    networkmanager = {
      enable = true;
    };
    
    firewall = {
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };

    extraHosts =
      ''
      192.168.1.10 bridget
      192.168.1.11 mai
      '';
  };
  time.timeZone = "Europe/Lisbon";
  
  services = {
    openssh = {
      enable = true;
    };
    printing = {
      enable = true;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
  
  services.xserver = {
    enable = true;
    
    displayManager.startx.enable = true;
    
    videoDrivers = ["nvidia"];
    
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3blocks
      ];
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    
    nvidia = {
      modesetting.enable = true; 
      nvidiaSettings = true;
      forceFullCompositionPipeline = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  users.users.bunny = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
  ];

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];
  };
  
  virtualisation = {
    docker = {
      enable = true;
    };
  };
    
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = "24.05";
}

