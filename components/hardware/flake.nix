{
	outputs = { self, nixpkgs }: {
		bluetooth = ./bluetooth.nix;
		sound = ./sound.nix;
		steam-controller = ./steam-controller.nix;
	};
}
