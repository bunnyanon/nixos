{ config, pkgs, ... }:

{
  home.file.".config/emacs" = {
    source = ./../../common/config/emacs;
    recursive = true;
  };

  home.packages = with pkgs; [
    eza
    git
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
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
