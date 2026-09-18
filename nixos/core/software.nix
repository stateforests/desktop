{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.mcsr-nixos.nixosModules.waywall
  ];

  # mcsr
  programs.waywall = {
    enable = true;
    config.source = /home/atlas/.config/waywall/init.lua;
  };

  environment.systemPackages = [
    (pkgs.prismlauncher.override {
      jdks = [ pkgs.temurin-bin-21 ];
      additionalLibs = [
        pkgs.libXtst
        pkgs.libXext
        pkgs.libX11
        pkgs.libxkbcommon
        pkgs.libxcb
        pkgs.libxt
        pkgs.libxinerama
        pkgs.jemalloc
      ];
    })
    
    pkgs.temurin-bin-21
    inputs.mcsr-nixos.packages.x86_64-linux.ninjabrain-bot
  ];

  # osu!
  hardware.opentabletdriver.enable = true;
  hardware.uinput.enable = true;
}
