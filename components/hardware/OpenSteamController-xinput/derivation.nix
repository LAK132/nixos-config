{
	fetchFromGitHub,
	rustPlatform,
	pkg-config,
	systemd,
	dbus,
}:

rustPlatform.buildRustPackage (finalAttrs: {
	pname = "OpenSteamController-xinput";
	version = "v1.2.0-xinput";

	cargoHash = "sha256-MfSuSSjrnf9yXYvaFW9GfBhy4xNrXlkyNkn4LzTc0A4=";

	src = fetchFromGitHub {
		owner = "LAK132";
		repo = "OpenSteamController";
		rev = "f572fc8d50344bb7b2d65a2db06f9755cb59513e";
		hash = "sha256-yFoLwmrEA6vKwJZD6udx0/OMKYuls9L4oHJ/KAGafpM=";
	};

	nativeBuildInputs = [
		pkg-config
	];

	buildInputs = [
		systemd
		dbus
	];

	postInstall = ''
		mv $out/bin/open-steam-controller $out/bin/open-steam-controller-xinput
	'';
})
