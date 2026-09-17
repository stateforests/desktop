{ config, pkgs, inputs, ... }:

let
    mcsrPkgs = inputs.mcsr-nixos.packages.x86_64-linux;
in 
{
  # mcsr
  imports = [ inputs.mcsr-nixos.nixosModules.waywall ];
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
      mcsrPkgs.ninjabrain-bot
  ];
}