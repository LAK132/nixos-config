{ config, pkgs, ... }:

{
	# --- boot ---

	boot = {
		supportedFilesystems = [ "ntfs" ];
	};

	# --- networking ---

	networking = {
		hostName = "halmarut";
		# hostId = (builtins.substring 0 8 (builtins.readFile "/etc/machine-id"));
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
