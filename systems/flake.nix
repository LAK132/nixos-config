{
	inputs = {
		codingway.url = ./codingway;
		matoya.url = ./matoya;
		minfilia.url = ./minfilia;
		mylla.url = ./mylla;
		ryne.url = ./ryne;
		yshtola.url = ./yshtola;
	};

	outputs = { self, nixpkgs, codingway, matoya, minfilia, mylla, ryne, yshtola }: {
		codingway = codingway;
		matoya = matoya;
		minfilia = minfilia;
		mylla = mylla;
		ryne = ryne;
		yshtola = yshtola;
	};
}
