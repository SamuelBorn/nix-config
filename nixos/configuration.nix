{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "23.11";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true; # Deduplicate and optimize nix store
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  # };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.born = {
    isNormalUser = true;
    description = "Samuel Born";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # fix running some binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ ];

  fonts = {
    packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
    fontconfig = {
      enable = true;
      defaultFonts = { monospace = [ "JetBrainsMono Nerd Font" ]; };
    };
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    powerManagement.enable = false;
    modesetting.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

  boot.extraModprobeConfig = ''
    options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3"
  '';

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    bat
    btop
    cargo
    cmake
    curl
    dunst
    eza
    firefox
    flameshot
    gcc
    git
    kitty
    libnotify
    mpv
    neofetch
    neovim
    nixfmt
    nodejs
    python3
    ripgrep
    rofi-wayland
    spotify
    swww
    tldr
    trash-cli
    unzip
    waybar
    wget
    wl-clipboard
    zoxide
    home-manager
    lazygit
    cantarell-fonts
    networkmanagerapplet
    prismlauncher
    jdk17
    discord
    input-remapper
  ];

  services.input-remapper.enable = true;
}
