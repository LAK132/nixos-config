{
	fetchFromGitHub,
	rustPlatform,
	pkg-config,
	systemd,
	dbus,
}:

rustPlatform.buildRustPackage (finalAttrs: {
	pname = "OpenSteamController";
	version = "v1.2.0";

	cargoHash = "sha256-MfSuSSjrnf9yXYvaFW9GfBhy4xNrXlkyNkn4LzTc0A4=";

	src = fetchFromGitHub {
		owner = "LennardKittner";
		repo = "OpenSteamController";
		tag = finalAttrs.version;
		hash = "sha256-v3Tvj5lQXDvLhFjx+RgyEGPZbya+pi8cD91yYM+q3yo=";
	};

	nativeBuildInputs = [
		pkg-config
	];

	buildInputs = [
		systemd
		dbus
	];
})
