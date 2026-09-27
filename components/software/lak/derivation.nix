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
	binaries =[
		"mdc-view"
		"nbt-view"
		"tiff-view"
		"x3f-view"
		"mdc2png"
	];
	installTargets = binaries ++ [
		"cobalt"
	];
	mesonFlags = [
		(lib.mesonBool "lak_enable_examples" true)
		(lib.mesonBool "lak_enable_windowing" true)
		(lib.mesonBool "lak_enable_glm" true)
		(lib.mesonBool "lak_enable_imgui" true)
		(lib.mesonBool "lak_enable_stb" true)
		(lib.mesonBool "lak_enable_stb_image" true)
		(lib.mesonBool "lak_enable_stb_image_write" true)
		(lib.mesonBool "sdl2_from_source" false)
		(lib.mesonOption "lak_backend" "sdl3")
		(lib.mesonOption "lak_renderer" "cobalt")
		(lib.mesonOption "cobalt_renderer" "OpenGL4")
		(lib.mesonOption "lak_install_targets" (lib.strings.join "," installTargets))
	];
in
stdenv.mkDerivation (finalAttrs: {
	pname = "lak";
	version = "v0.1.5";
	meta.maintainers = [{
		name = "LAK132";
		github = "LAK132";
		githubId = 1386467;
	}];

	src = fetchFromGitHub {
		owner = "LAK132";
		repo = "lak";
		# tag = finalAttrs.version;
		rev = "687ddada170209594ebd3edebc4325a0a7e7ec77";
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

		hash = "sha256-KY+5yO3vWFLpP7S8Yesq+OoEr3u9XSRAbbbIJUGe8hY=";
	};

	# runs out of ram in release builds
	mesonBuildType = "debug";

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

	postFixup = (lib.strings.join " " (lib.forEach binaries (b: ''
		wrapProgram $out/bin/${b} \
			--set LD_LIBRARY_PATH "${lib.makeLibraryPath [ vulkan-loader ]}"
	'')));
})
