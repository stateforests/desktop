{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./mcsr.nix
  ];

  # boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtw88
  ];

  # networking
  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  # localization
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # user
  users.users.atlas = {
    isNormalUser = true;
    description = "Atlas";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # programs
  programs.fish.enable = true;
  programs.helium.enable = true;
  programs.xwayland.enable = true;

  # hardware
  hardware.graphics.enable = true;

  # services
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --cmd '${pkgs.jay}/bin/jay run'";
      user = "atlas";
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # packages
  environment.systemPackages = with pkgs; [
    # desktop
    jay
    wezterm
    fuzzel
    mako
    waybar
    adwaita-icon-theme

    # applications
    equibop
    spotify
    vscodium
    steam
    obs-studio
    kdePackages.kdenlive
    mpv
    keepassxc

    # utilities
    git
    gcc
    cmake
    unzip
    fastfetch
    btop
    playerctl
    libnotify
    wl-clipboard
    grim
    slurp
    swayimg

    # fonts
    nerd-fonts.meslo-lg

    # display manager
    tuigreet
  ];

  # xdg
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/html" = "helium.desktop";
      "application/xhtml+xml" = "helium.desktop";
      "x-scheme-handler/http" = "helium.desktop";
      "x-scheme-handler/https" = "helium.desktop";
      "x-scheme-handler/chrome" = "helium.desktop";

      "image/jpeg" = "swayimg.desktop";
      "image/png" = "swayimg.desktop";
      "image/gif" = "swayimg.desktop";
      "image/webp" = "swayimg.desktop";
      "image/svg+xml" = "swayimg.desktop";

      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
    };
  };

  # environment
  environment.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  # nix
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";
}