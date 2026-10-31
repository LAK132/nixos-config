{
	inputs = {
		codingway.url = ./codingway;
		halmarut.url = ./halmarut;
		kicodora.url = ./kicodora;
		matoya.url = ./matoya;
		minfilia.url = ./minfilia;
		mylla.url = ./mylla;
		ryne.url = ./ryne;
		yshtola.url = ./yshtola;
	};

	outputs = {
		self, nixpkgs,
		codingway,
		halmarut,
		kicodora,
		matoya,
		minfilia,
		mylla,
		ryne,
		yshtola
	}: {
		codingway = codingway;
		halmarut = halmarut;
		kicodora = kicodora;
		matoya = matoya;
		minfilia = minfilia;
		mylla = mylla;
		ryne = ryne;
		yshtola = yshtola;
	};
}
