{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		git
		python3
		usbutils
		neofetch
		wine
	];

	users.users.lak132.packages = with pkgs; [
		winetricks
		vscode
	];
}
