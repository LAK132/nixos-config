{
	inputs = {
		components.url = ./../../components;
	};

	outputs = { self, nixpkgs, components }: {
		config = args: nixpkgs.lib.nixosSystem (args // {
			system = "x86_64-linux";
			modules = args.modules ++ [
				./configuration.nix
				components.lak132
				components.software.dev
			];
		});
	};
}
