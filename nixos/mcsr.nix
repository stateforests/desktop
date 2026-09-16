{ config, pkgs, inputs, ... }:

let
  mcsrPkgs = inputs.mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ inputs.mcsr-nixos.nixosModules.waywall ];

  # waywall
  programs.waywall.enable = true;
  programs.waywall.config.source = "/home/atlas/.config/waywall/init.lua";

  # packages
  environment.systemPackages = [
    (pkgs.prismlauncher.override {
      jdks = [ mcsrPkgs.graalvm-21 ];
      additionalLibs = [
        pkgs.pkgsi686Linux.libxtst
        pkgs.libXext
        pkgs.libX11
        pkgs.libxkbcommon
        pkgs.libxcb
        pkgs.libxt
        pkgs.libxinerama
        pkgs.jemalloc
      ];
    })

    pkgs.openjdk21
    mcsrPkgs.ninjabrain-bot
    inputs.ninjabrain-bot-xwayland.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # drag clicking fix
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Never Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=1
  '';
}