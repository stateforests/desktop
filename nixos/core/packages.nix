{ inputs, pkgs, ... }:

{
  environment.systemPackages =
    [
      inputs.jay-screenshot.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ (with pkgs; [
      git
      gcc
      cmake
      unzip
      fastfetch
      btop

      jay
      tuigreet
      wezterm
      fuzzel
      mako
      waybar
      waylock
      swaybg
      wl-clipboard
      grim
      slurp
      swayimg
      libnotify
      playerctl

      adwaita-icon-theme
      nerd-fonts.meslo-lg

      equibop
      spotify
      vscode
      steam
      obs-studio
      kdePackages.kdenlive
      mpv
      keepassxc
    ]);
}