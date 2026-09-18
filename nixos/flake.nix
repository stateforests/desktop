{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    helium.url = "github:oxcl/nix-flake-helium-browser";
    helium.inputs.nixpkgs.follows = "nixpkgs";

    mcsr-nixos.url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
    mcsr-nixos.inputs.nixpkgs.follows = "nixpkgs";

    nix-osu-stable.url = "github:gaavin/nix-osu-stable";
    nix-osu-stable.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./core/hardware.nix
        ./core/system.nix
        ./core/desktop.nix
        ./core/packages.nix
        ./core/specific.nix
      ];
    };
  };
}