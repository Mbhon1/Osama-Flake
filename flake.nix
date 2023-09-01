{
  description = "Home manager Configuration for Mbhon1";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    fu.url = "github:numtide/flake-utils";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    ags.url = "github:Aylur/ags";
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    # FIXME:flatpak.url = "github:yawnt/declarative-nix-flatpak/main";
    # xdm.url = "https://github.com/subhra74/xdm.git";
  };

  outputs = { 
    nixpkgs, 
    home-manager, 
    spicetify-nix, 
    self,
    hyprland,
    flatpaks,
    ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ 
        /home/mbhon1/.config/nixos/configuration.nix
        flatpaks.homeManagerModules.default
        home-manager.nixosModules.home-manager
        {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mbhon1 = import ./home.nix;
          }
        ];
      };
    };

    homeConfigurations = {
      "mbhon1" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; 
        extraSpecialArgs = { inherit spicetify-nix; }; 
        modules = [ 
          hyprland.homeManagerModules.default
          { wayland.windowManager.hyprland.enable = true; }
          ./home.nix 
        ];
      };
    };
  };

}
