{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		git
		python3
		usbutils
		fastfetch
		wine
	];

	users.users.lak132.packages = with pkgs; [
		winetricks
		gparted
		vscode
		clang-tools # clang-format
	];
}
