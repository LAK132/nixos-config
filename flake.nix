{
	outputs = { self, nixpkgs }: {
		minfilia = args: nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = args.modules ++ [ ./minfilia/configuration.nix ];
		};
		ryne = args: nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = args.modules ++ [ ./ryne/configuration.nix ];
		};
		yshtola = args: nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = args.modules ++ [ ./yshtola/configuration.nix ];
		};
	};
}
