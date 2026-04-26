{
	inputs = {
		software.url = ./software;
	};

	outputs = { self, nixpkgs, software }: {
		lak132 = ./lak132.nix;
		software = software;
	};
}
