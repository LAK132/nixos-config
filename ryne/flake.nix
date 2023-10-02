{
	inputs.filestash-nix.url = "github:matthewcroughan/filestash-nix";

	outputs = { self, nixpkgs, filestash-nix, arion }: {
		config = args: nixpkgs.lib.nixosSystem (args // {
			system = "x86_64-linux";
			modules = args.modules ++ [
				arion.nixosModule.arion
				filestash-nix.nixosModule {
					services.filestash.enable = true;
				}
				./configuration.nix
			];
		});
	};
}
