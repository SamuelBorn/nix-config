{ inputs, lib, config, pkgs, ... }: {

  imports = [
    # ./nvim.nix
  ];

  home = {
    username = "born";
    homeDirectory = "/home/born";
  };

  # Enable home-manager 
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = "nvim";
    XCURSOR_THEME = "Adwaita";
  };

  home.sessionPath = [ "~/.cargo/bin" ];

  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark";
    settings = {
      confirm_os_window_close = 0;
      hide_window_decorations = true;
      enable_audio_bell = false;
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      cd = "z";
      ls = "eza --all";
      ll = "eza --long --all";
      lg = "lazygit";
      rebuild-nix = "sudo nixos-rebuild switch --flake ~/Repos/nix-config";
      rebuild-home = "home-manager switch --flake ~/Repos/nix-config";
      venv =
        "source venv/bin/activate || python -m venv venv && source venv/bin/activate";
    };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };
}
