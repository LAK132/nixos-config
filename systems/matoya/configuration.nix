{ config, pkgs, ... }:

{
	# --- boot ---

	boot = {
		supportedFilesystems = [ "ntfs" ];
	};

	# --- networking ---

	networking = {
		hostName = "matoya";
		# hostId = (builtins.substring 0 8 (builtins.readFile "/etc/machine-id"));
		networkmanager.enable = true;
	};

	# --- time ---

	time.timeZone = "Australia/Adelaide";

	# --- hardware ---

	services.xserver.videoDrivers = [ "nvidia" ];

	hardware.nvidia.open = false; # GTX960M

	# --- software ---

	nixpkgs.config.allowUnfree = true;

	# Enable CUPS to print documents.
	services.printing.enable = true;
}
