{
	inputs = {
		components.url = ./../../components;
		filestash-nix.url = "github:matthewcroughan/filestash-nix";
	};

	outputs = { self, nixpkgs, components, filestash-nix, arion }: {
		config = args: nixpkgs.lib.nixosSystem (args // {
			system = "x86_64-linux";
			modules = args.modules ++ [
				./configuration.nix
				components.lak132
				components.software.dev
				components.lak132
				components.display.mate
				components.hardware.sound
				components.software.dev
				components.software.internet
				arion.nixosModules.arion
				filestash-nix.nixosModule {
					services.filestash.enable = true;
				}
			];
		});
	};
}
