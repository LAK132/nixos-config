{
	inputs = {
		systems.url = ./systems;
	};

	outputs = { self, nixpkgs, systems }: {
		nixosConfigurations = args: {
			codingway = systems.codingway.config args;
			matoya = systems.matoya.config args;
			minfilia = systems.minfilia.config args;
			mylla = systems.mylla.config args;
			ryne = systems.ryne.config args;
			yshtola = systems.yshtola.config args;
		};
	};
}
