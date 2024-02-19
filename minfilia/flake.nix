{
	outputs = { self, nixpkgs, arion }: {
		config = args: nixpkgs.lib.nixosSystem (args // {
			system = "x86_64-linux";
			modules = args.modules ++ [ 
				./configuration.nix
				arion.nixosModules.arion
			];
		});
	};
}
