{ ... }:

{
  imports = [
    ./core/hardware.nix
    ./core/system.nix
    ./core/display.nix
    ./core/desktop.nix
    ./core/packages.nix
  ];

  system.stateVersion = "25.11";
}