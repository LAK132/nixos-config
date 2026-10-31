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
