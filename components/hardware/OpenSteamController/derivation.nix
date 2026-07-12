{
	fetchFromGitHub,
	rustPlatform,
	pkg-config,
	systemd,
	dbus,
}:

rustPlatform.buildRustPackage (finalAttrs: {
	pname = "OpenSteamController";
	version = "v1.1.0";

	cargoHash = "sha256-S3Sh60VMCWX2mGE59TELRoWg4TUD9rfzyc81jH6YMig=";

	src = fetchFromGitHub {
		owner = "LennardKittner";
		repo = "OpenSteamController";
		tag = finalAttrs.version;
		hash = "sha256-UtXPir8PLuE8EqDVMdGJXsRwLcuzbIz37DMerR2iFAg=";
	};

	nativeBuildInputs = [
		pkg-config
	];

	buildInputs = [
		systemd
		dbus
	];
})
