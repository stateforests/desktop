{ config, pkgs, ... }:

{
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

    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  # hardware
  hardware.graphics.enable = true;

  # audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # nix
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}