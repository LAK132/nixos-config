{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		git
		gcc
		meson
		cmake
		python3
		usbutils
		fastfetch
		wine
		rustup
	];

	users.users.lak132.packages = with pkgs; [
		winetricks
		gparted
		vscode
		clang-tools # clang-format
		ddd
	];
}
