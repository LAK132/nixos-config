{ config, pkgs, ... }:

{
	# --- boot ---

	boot = {
		supportedFilesystems = [ "ntfs" ];
	};

	# --- networking ---

	networking = {
		hostName = "yshtola";
		networkmanager.enable = true;
	};

	# --- time ---

	time.timeZone = "Australia/Adelaide";

	# --- hardware ---

	services.xserver = {
		videoDrivers = [ "nvidia" ];
		wacom.enable = true;
	};

	hardware.nvidia.open = true; # RTX2060

	# --- software ---

	nixpkgs.config.allowUnfree = true;

	# enable CUPS to print documents
	services.printing.enable = true;
}
