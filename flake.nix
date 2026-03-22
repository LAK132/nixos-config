{
	inputs = {
		lak132.url = "./lak132";
		matoya.url = "./matoya";
		minfilia.url = "./minfilia";
		mylla.url = "./mylla";
		ryne.url = "./ryne";
		yshtola.url = "./yshtola";
	};

	outputs = { self, nixpkgs, lak132, matoya, minfilia, mylla, ryne, yshtola }: {
		matoya = args: matoya.config (args // { modules = args.modules ++ [ lak132.user lak132.dev ]; });
		minfilia = args: minfilia.config (args // { modules = args.modules ++ [ lak132.user lak132.dev ]; });
		mylla = args: mylla.config (args // { modules = args.modules ++ [ lak132.user lak132.dev ]; });
		ryne = args: ryne.config (args // { modules = args.modules ++ [ lak132.user lak132.dev ]; });
		yshtola = args: yshtola.config (args // { modules = args.modules ++ [lak132.user lak132.dev ]; });
	};
}
