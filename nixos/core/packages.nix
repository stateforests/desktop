{ pkgs, ... }:

{
  # programs
  programs.helium.enable = true;
  programs.xwayland.enable = true;
  programs.fish.enable = true;
  
  # packages
  environment.systemPackages = with pkgs; [
    # desktop
    jay
    wezterm
    fuzzel
    mako
    waybar
    adwaita-icon-theme
    swaylock
    swaybg
    swayimg

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

    # fonts
    nerd-fonts.meslo-lg
  ];
}