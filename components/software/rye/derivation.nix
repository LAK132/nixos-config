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
		rev = "20bd1a00a34c7cd6f5bd0d3862b05627f8229374";
		leaveDotGit = true;
		fetchTags = true;

		nativeBuildInputs = [ cacert ] ++ nativeBuildInputs;
		postFetch = ''
			cd "$out"
			meson setup build ${lib.strings.join " " mesonFlags}
			rm -rf build
			for f in subprojects/*/.meson-subproject-wrap-hash.txt; do
				rm "$f"
			done
			for d in subprojects/*/.git; do
				rm -rf "$d"
			done
			for d in subprojects/Cobalt/External/Cache/*/.git; do
				rm -rf "$d"
			done
			git_hash="`git rev-parse --short HEAD`" || exit 1
			git_tag="`git describe --tags --always --abbrev=0`" || exit 1
			echo "echo \"#ifndef GIT_HASH\" > \$1" > generate_git_file.sh
			echo "echo \"#define GIT_HASH \\\"$git_hash\\\"\" >> \$1" >> generate_git_file.sh
			echo "echo \"#endif\" >> \$1" >> generate_git_file.sh
			echo "echo \"#ifndef GIT_TAG\" >> \$1" >> generate_git_file.sh
			echo "echo \"#define GIT_TAG \\\"$git_tag\\\"\" >> \$1" >> generate_git_file.sh
			echo "echo \"#endif\" >> \$1" >> generate_git_file.sh
			rm -rf .git
		'';

		hash = "sha256-FCLoaGtMFdFrkn576N96NQtmJlo/GedseBQpA+xa72s=";
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
