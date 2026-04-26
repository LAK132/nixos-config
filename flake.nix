{
	inputs = {
		lak132.url = "./lak132";
		codingway.url = "./systems/codingway";
		matoya.url = "./systems/matoya";
		minfilia.url = "./systems/minfilia";
		mylla.url = "./systems/mylla";
		ryne.url = "./systems/ryne";
		yshtola.url = "./systems/yshtola";
	};

	outputs = { self, nixpkgs, lak132, codingway, matoya, minfilia, mylla, ryne, yshtola }: {
		codingway = args: codingway.config (args // { modules = args.modules ++ [ lak132.user lak132.dev ]; });
		matoya = args: matoya.config (args // { modules = args.modules ++ [ lak132.user lak132.dev ]; });
		minfilia = args: minfilia.config (args // { modules = args.modules ++ [ lak132.user lak132.dev ]; });
		mylla = args: mylla.config (args // { modules = args.modules ++ [ lak132.user lak132.dev ]; });
		ryne = args: ryne.config (args // { modules = args.modules ++ [ lak132.user lak132.dev ]; });
		yshtola = args: yshtola.config (args // { modules = args.modules ++ [lak132.user lak132.dev ]; });
	};
}
