{
	stdenv,
	lib,
	cacert,
	fetchFromGitHub,
	git,
	meson,
	ninja,
	gcc,
	cmake,
	pkg-config,
	python3,
	sdl3,
	libglvnd,
	libgbm,
	libxau,
	libxdmcp,
	libxcb,
	libx11,
	libxrandr,
	libffi,
	libxkbcommon,
	libdecor,
	wayland-scanner,
	wayland-protocols,
	egl-wayland,
	wayland,
	vulkan-loader,
	cairo,
	makeWrapper,
}:

# https://phip1611.de/blog/accessing-network-from-a-nix-derivation/

let
	nativeBuildInputs = [
		git
		meson
		ninja
		gcc
		cmake
		pkg-config
		python3
		sdl3
		libglvnd
		libgbm
		libxau
		libxdmcp
		libxcb
		libx11
		libxrandr
		libffi
		libxkbcommon
		libdecor
		wayland-scanner
		wayland-protocols
		egl-wayland
		wayland
		cairo
	];
	mesonFlags = [
		(lib.mesonOption "lak_backend" "sdl3")
	];
in
stdenv.mkDerivation (finalAttrs: {
	pname = "rye";
	version = "v0.1.8";
	meta.maintainers = [{
		name = "LAK132";
		github = "LAK132";
		githubId = 1386467;
	}];

	src = fetchFromGitHub {
		owner = "LAK132";
		repo = "rye";
		# tag = finalAttrs.version;
		rev = "9d79eee6a7d5d55176141b7d88601a4c28080198";
		leaveDotGit = true;
		fetchTags = true;

		nativeBuildInputs = [ cacert ] ++ nativeBuildInputs;
		postFetch = ''
			cd "$out"
			meson setup build ${lib.strings.join " " mesonFlags}
			rm -rf build
			for d in subprojects/*/.git; do
				rm -rf "$d"
			done
			for d in subprojects/Cobalt/External/Cache/*/.git; do
				rm -rf "$d"
			done
		'';

		hash = "sha256-aaRy/uxCrE9vEHhpYBfaVFf7caKLvuVskp9auAxo7FE=";
	};

	mesonBuildType = "release";

	nativeBuildInputs = nativeBuildInputs ++ [
		makeWrapper
	];

	buildInputs = [
		sdl3
		libxkbcommon
		wayland
		vulkan-loader
	];

	mesonFlags = mesonFlags ++ [
		(lib.mesonBool "cobalt_cmake_no_download" true)
	];

	postFixup = ''
		wrapProgram $out/bin/${finalAttrs.pname} \
			--set LD_LIBRARY_PATH "${lib.makeLibraryPath [ vulkan-loader ]}"
	'';
})
