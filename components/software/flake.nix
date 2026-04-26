{
	outputs = { self, nixpkgs }: {
		dev = ./dev.nix;
		gaming = ./gaming.nix;
		internet = ./internet.nix;
		media = ./media.nix;
		social = ./social.nix;
	};
}
