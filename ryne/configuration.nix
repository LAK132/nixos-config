{ config, pkgs, ... }:

{
	# --- boot ---

	boot = {
		loader = {
			systemd-boot.enable = true;
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot/efi";
			};
		};
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

	# --- graphics ---

	services.xserver = {
		enable = true;
		displayManager.lightdm.enable = true;
		desktopManager.mate.enable = true;
		layout = "au";
		xkbVariant = "";
	};

	hardware.opengl.enable = true;

	# --- sound ---

	sound.enable = true;

	hardware.pulseaudio.enable = false;

	security.rtkit.enable = true;

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	# --- software ---

	nixpkgs.config.allowUnfree = true;

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};

	users.extraGroups.docker.members = [ "lak132" ];

	environment.systemPackages = with pkgs; [
		docker-compose
	];

	users.users.lak132.packages = with pkgs; [
		firefox
		discord
		spotify
		flameshot
		steam-run
		xivlauncher
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
