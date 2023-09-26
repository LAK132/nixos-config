{
	inputs.filestash-nix.url = "github:matthewcroughan/filestash-nix";

	outputs = { self, nixpkgs, filestash-nix }: {
		config = args: nixpkgs.lib.nixosSystem (args // {
			system = "x86_64-linux";
			modules = args.modules ++ [ 
				./configuration.nix
				filestash-nix.nixosModule {
					services.filestash.enable = true;
				}
			];
		});
	};
}
