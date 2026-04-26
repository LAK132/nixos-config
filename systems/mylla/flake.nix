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
				components.display.mate
				components.hardware.sound
				components.software.dev
				components.software.internet
				components.software.media
				components.software.social
			];
		});
	};
}
