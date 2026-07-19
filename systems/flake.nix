{
	inputs = {
		codingway.url = ./codingway;
		halmarut.url = ./halmarut;
		matoya.url = ./matoya;
		minfilia.url = ./minfilia;
		mylla.url = ./mylla;
		ryne.url = ./ryne;
		yshtola.url = ./yshtola;
	};

	outputs = { self, nixpkgs, codingway, halmarut, matoya, minfilia, mylla, ryne, yshtola }: {
		codingway = codingway;
		halmarut = halmarut;
		matoya = matoya;
		minfilia = minfilia;
		mylla = mylla;
		ryne = ryne;
		yshtola = yshtola;
	};
}
