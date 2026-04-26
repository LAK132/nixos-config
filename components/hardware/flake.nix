{
	outputs = { self, nixpkgs }: {
		bluetooth = ./bluetooth.nix;
		sound = ./sound.nix;
	};
}
