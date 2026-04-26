{
	inputs = {
		components.url = ./components;
		systems.url = ./systems;
	};

	outputs = { self, nixpkgs, components, systems }: {
		codingway = args: systems.codingway.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
		matoya = args: systems.matoya.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
		minfilia = args: systems.minfilia.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
		mylla = args: systems.mylla.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
		ryne = args: systems.ryne.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
		yshtola = args: systems.yshtola.config (args // {
			modules = args.modules ++ [
				components.lak132
				components.software.dev
			];
		});
	};
}
