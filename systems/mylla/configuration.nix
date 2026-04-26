{ config, pkgs, ... }:

{
	# --- boot ---

	boot = {
		supportedFilesystems = [ "ntfs" ];
	};

	# --- networking ---

	networking = {
		hostName = "mylla";
		networkmanager.enable = true;
	};

	programs.nm-applet.enable = true;

	# --- time ---

	time.timeZone = "Australia/Adelaide";

	# --- hardware ---

	# --- software ---

	nixpkgs.config.allowUnfree = true;

	# enable CUPS to print documents
	services.printing.enable = true;
}
