{
	inputs = {
		systems.url = ./systems;
	};

	outputs = { self, nixpkgs, systems }: {
		codingway = args: systems.codingway.config (args // {
			modules = args.modules ++ [
			];
		});
		matoya = args: systems.matoya.config (args // {
			modules = args.modules ++ [
			];
		});
		minfilia = args: systems.minfilia.config (args // {
			modules = args.modules ++ [
			];
		});
		mylla = args: systems.mylla.config (args // {
			modules = args.modules ++ [
			];
		});
		ryne = args: systems.ryne.config (args // {
			modules = args.modules ++ [
			];
		});
		yshtola = args: systems.yshtola.config (args // {
			modules = args.modules ++ [
			];
		});
	};
}
