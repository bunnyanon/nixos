{ config, pkgs, ... }:

{
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;  
  };

  system.stateVersion = 4;

  homebrew = {
    enable = true;

    casks = [
      "firefox"
      "alacritty"
      "emacs"
    ];
  };

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };

    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
  };
}

