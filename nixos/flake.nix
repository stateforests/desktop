{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    jay = {
      url = "github:mahkoh/jay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jay-screenshot = {
      url = "github:Ktrompfl/jay-screenshot";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.jay.follows = "jay";
    };

    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      ];
    };
  };
}