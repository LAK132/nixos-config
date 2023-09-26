{
	outputs = { self, nixpkgs }: {
		dev = ./dev.nix;
		user = ./user.nix;
	};
}
