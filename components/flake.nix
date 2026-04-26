{
	inputs = {
		display.url = ./display;
		hardware.url = ./hardware;
		software.url = ./software;
	};

	outputs = { self, nixpkgs, display, hardware, software }: {
		lak132 = ./lak132.nix;
		display = display;
		hardware = hardware;
		software = software;
	};
}
