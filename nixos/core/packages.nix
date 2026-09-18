{ inputs, pkgs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
  helium = inputs.helium.packages.${system}.default;
in
{
  environment.systemPackages = [
    helium
  ] ++ (with pkgs; [
    git
    unzip
    zip
    wget
    fastfetch
    btop
    zenity

    jay
    tuigreet
    wezterm
    fuzzel
    mako
    waybar
    wl-clipboard
    grim
    slurp
    swayimg
    playerctl

    adwaita-icon-theme
    nerd-fonts.meslo-lg

    equibop
    spotify
    vscode
    obs-studio
    kdePackages.kdenlive
    mpv
    keepassxc
    vinegar

    steam
    osu-lazer-bin
  ]);
}