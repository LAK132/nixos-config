{ config, pkgs, ... }:

{
	# --- boot ---

	boot = {
		supportedFilesystems = [ "ntfs" ];
	};

	# --- networking ---

	networking = {
		hostName = "ryne";
		# hostId = (builtins.substring 0 8 (builtins.readFile "/etc/machine-id"));
		networkmanager.enable = true;
		firewall.allowedTCPPorts = [ 80 443 ];
	};

	# --- time ---

	time.timeZone = "Australia/Adelaide";

	# --- hardware ---

	# --- software ---

	nixpkgs.config.allowUnfree = true;

	users.extraGroups.docker.members = [ "lak132" ];

	environment.systemPackages = with pkgs; [
		docker-compose
	];

	# enable CUPS to print documents
	services.printing.enable = true;

	services.openssh.enable = true;

	virtualisation.arion = {
		backend = "docker";
		projects = {
		};
	};
}
