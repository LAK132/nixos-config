{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
		components.url = ./../../components;
	};

	outputs = { self, nixpkgs, components, arion }: {
		config = args: nixpkgs.lib.nixosSystem (args // {
			system = "x86_64-linux";
			modules = args.modules ++ [
				./configuration.nix
				components.lak132
				components.display.mate
				components.software.dev
				components.software.internet
				arion.nixosModules.arion
			];
		});
	};
}
