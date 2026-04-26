{
	inputs = {
		components.url = ./components;
		codingway.url = ./systems/codingway;
		matoya.url = ./systems/matoya;
		minfilia.url = ./systems/minfilia;
		mylla.url = ./systems/mylla;
		ryne.url = ./systems/ryne;
		yshtola.url = ./systems/yshtola;
	};

	outputs = { self, nixpkgs, components, codingway, matoya, minfilia, mylla, ryne, yshtola }: {
		codingway = args: codingway.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
		matoya = args: matoya.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
		minfilia = args: minfilia.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
		mylla = args: mylla.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
		ryne = args: ryne.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
		yshtola = args: yshtola.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
	};
}
