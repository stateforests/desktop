{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtw88  # for my external wifi adapter
  ];

  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  programs.fish.enable = true;
  users.users.atlas = {
    isNormalUser = true;
    description = "Atlas";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  hardware.graphics.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "-d";
  };

  system.stateVersion = "25.11";
}