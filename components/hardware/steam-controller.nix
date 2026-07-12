{ config, pkgs, ... }:

{
	users.users.lak132.packages = with pkgs; [
		(callPackage ./OpenSteamController/derivation.nix {})
	];

	services.udev.extraRules = ''
		SUBSYSTEMS=="usb", ATTRS{idProduct}=="1302", ATTRS{idVendor}=="28de", MODE="0666"
		SUBSYSTEMS=="usb", ATTRS{idProduct}=="1303", ATTRS{idVendor}=="28de", MODE="0666"
		SUBSYSTEMS=="usb", ATTRS{idProduct}=="1304", ATTRS{idVendor}=="28de", MODE="0666"
		KERNEL=="hidraw*", ATTRS{idProduct}=="1302", ATTRS{idVendor}=="28de", MODE="0666"
		KERNEL=="hidraw*", ATTRS{idProduct}=="1303", ATTRS{idVendor}=="28de", MODE="0666"
		KERNEL=="hidraw*", ATTRS{idProduct}=="1304", ATTRS{idVendor}=="28de", MODE="0666"
	'';
}
