{ inputs, pkgs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
  osu = inputs.nix-osu-stable.packages.${system};
  helium = inputs.helium.packages.${system};
in
{
  environment.systemPackages =
    [
      helium.default
      osu.osu-wine
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

      steam
      equibop
      spotify
      vscode
      obs-studio
      kdePackages.kdenlive
      mpv
      keepassxc
      vinegar
    ]);
}
