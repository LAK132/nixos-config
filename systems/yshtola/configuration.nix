{ config, pkgs, ... }:

{
	# --- boot ---

	boot = {
		supportedFilesystems = [ "ntfs" ];
	};

	fileSystems."/mnt/minfilia" = {
		device = "lak132@minfilia.lan:/mnt/nas";
		fsType = "sshfs";
		options = [
			"allow_other"
			"noatime"
			"_netdev"
			"reconnect"
			"IdentityFile=/var/secrets/minfilia_id_rsa"
		];
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

	programs.virt-manager.enable = true;

	users.groups.libvirtd.members = [ "lak132" ];
	users.users.lak132.extraGroups = [ "libvirtd" ];

	virtualisation.libvirtd.enable = true;

	virtualisation.spiceUSBRedirection.enable = true;

	# enable CUPS to print documents
	services.printing.enable = true;
}
