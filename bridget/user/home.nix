{ config, pkgs, ... }:

{
  home.username = "bunny";
  home.homeDirectory = "/home/bunny";

  home.file.".config/i3" = {
    source = ./../../common/config/i3;
    recursive = true;
  };
   
  home.file.".config/emacs" = {
    source = ./../../common/config/emacs;
    recursive = true;
  };

  home.packages = with pkgs; [
    firefox
    alacritty
    git
    lxappearance
    neofetch
    dconf
    emacs
    picom
    xwallpaper
  ];

  programs.git = {
    enable = true;
    userName = "BunnyAnon";
    userEmail = "bunnyanonn@proton.me";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.alacritty = {
    enable = true;
    settings = import ./../../common/programs/alacritty/alacritty.nix;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };
    
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
