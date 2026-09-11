{
	outputs = { self, nixpkgs }: {
		dev = ./dev.nix;
		gaming = ./gaming.nix;
		internet = ./internet.nix;
		media = ./media.nix;
		multimedia = ./multimedia.nix;
		office = ./office.nix;
		social = ./social.nix;
	};
}
