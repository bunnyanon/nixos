{
  description = "My System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager }: {
    nixosConfigurations = {
      bridget = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./bridget/system/configuration.nix
          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
              
            home-manager.users.bunny = import ./bridget/user/home.nix;
          }
        ];
      };
    };

    darwinConfigurations = {
      aba = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
	modules = [ 
          ./aba/system/darwin.nix

	  home-manager.darwinModules.home-manager
	  {
            users.users.bunny = {
              name = "bunny";
              home = "/Users/bunny";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
              
            home-manager.users.bunny = import ./aba/user/home.nix;
	  }
	];
      };
    };
  };
}
