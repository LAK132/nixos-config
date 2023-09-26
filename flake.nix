{
	inputs = {
		lak132.url = "./lak132";
		minfilia.url = "./minfilia";
		ryne.url = "./ryne";
		yshtola.url = "./yshtola";
	};

	outputs = { self, nixpkgs, lak132, minfilia, ryne, yshtola }: {
		minfilia = args: minfilia.config (args // { modules = args.modules ++ [ lak132.user lak132.dev ]; });
		ryne = args: ryne.config (args // { modules = args.modules ++ [ lak132.user lak132.dev ]; });
		yshtola = args: yshtola.config (args // { modules = args.modules ++ [lak132.user lak132.dev ]; });
	};
}
