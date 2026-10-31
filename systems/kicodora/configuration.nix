{ config, pkgs, ... }:

{
	# --- boot ---

	# --- networking ---

	networking = {
		hostName = "kicodora";
		networkmanager.enable = true;
	};

	# --- time ---

	time.timeZone = "Australia/Adelaide";

	# --- hardware ---

	hardware.graphics.enable = true;

	# by default the USB port uses a safe current limit of only 500mA, and uses
	# typical USB communication to negotiate higher currents with connected
	# devices. the pinephone keyboard seems to use the same 5V line as the USB
	# port, but has no way of negotiating the higher current limit necessary to
	# charge the phone from the keyboard. one-shotting input_current_limit to
	# 1.5A should be safe enough so long as the phone is never connected to a
	# dumb power supply, but should negotiate down if the phone's USB port is
	# used without the keyboard connected.
	#
	# WARNING: THE PHONE'S USB PORT SHOULD NEVER BE CONNECTED TO A POWER SUPPLY
	#          WHILE THE KEYBOARD IS ATTACHED
	services.udev.extraRules = ''
		SUBSYSTEM=="power_supply", KERNEL=="axp20x-usb", ATTR{input_current_limit}="1500000"
	'';

	# --- software ---

	environment.systemPackages = with pkgs; [
		git
		gcc
		meson
		cmake
		python3
		usbutils
		fastfetch
		rustup
	];

	users.users.lak132.packages = with pkgs; [
		gparted
	];

	environment.variables = {
		# Qt apps won't always start unless this env var is set
		QT_QPA_PLATFORM = "wayland";
	};

	security.sudo = {
		enable = true;
		wheelNeedsPassword = false;
	};

	services.xserver.desktopManager.phosh.user = "lak132";

	nixpkgs.config.allowUnfree = true;
}
