{ pkgs, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
  mcsr = inputs.mcsr-nixos.packages.${system};
in
{
  imports = [
    inputs.mcsr-nixos.nixosModules.waywall
  ];

  # waywall
  programs.waywall = {
    enable = true;
    config.source = "/home/atlas/.config/waywall/init.lua";
  };

  # packages
  environment.systemPackages = [
    (pkgs.prismlauncher.override {
      jdks = [ mcsr.graalvm-21 ];

      additionalLibs = with pkgs; [
        pkgsi686Linux.libxtst
        libXext
        libX11
        libxkbcommon
        libxcb
        libxt
        libxinerama
        jemalloc
      ];
    })

    pkgs.openjdk21
    mcsr.ninjabrain-bot
    inputs.ninjabrain-bot-xwayland.packages.${system}.default
  ];

  # drag clicking fix
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Never Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=1
  '';
}