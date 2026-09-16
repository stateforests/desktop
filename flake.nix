{
  description = "NixOS flake";

  # inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    helium.url = "github:oxcl/nix-flake-helium-browser";
    helium.inputs.nixpkgs.follows = "nixpkgs";

    mcsr-nixos.url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
    mcsr-nixos.inputs.nixpkgs.follows = "nixpkgs";

    ninjabrain-bot-xwayland.url = "github:Ktrompfl/ninjabrain-bot-xwayland";
    ninjabrain-bot-xwayland.inputs.nixpkgs.follows = "nixpkgs";
  };

  # outputs
  outputs = { nixpkgs, helium, ... }@inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
        helium.nixosModules.default
      ];
    };
  };
}