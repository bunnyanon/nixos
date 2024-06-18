{ config, pkgs, ... }:

{
  home.username = "bunny";
  home.homeDirectory = "/home/bunny";

  home.file.".config/i3" = {
    source = ./config/i3;
    recursive = true;
  };
   
  home.file.".config/emacs" = {
    source = ./config/emacs;
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
    settings = import ./programs/alacritty/alacritty.nix;
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
