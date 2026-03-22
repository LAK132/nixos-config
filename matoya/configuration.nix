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

	# --- graphics ---

	services = {
		xserver = {
			enable = true;
			videoDrivers = [ "nvidia" ];
			xkb = {
				layout = "au";
				variant = "";
			};
		};
		displayManager.sddm.enable = true;
		desktopManager.plasma6.enable = true;
	};

	hardware = {
		graphics.enable = true;
		nvidia.open = false; # GTX960M
	};

	# --- sound ---

	services = {
		pulseaudio.enable = false;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};
	};

	security.rtkit.enable = true;

	# --- software ---

	nixpkgs.config.allowUnfree = true;

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};

	environment.systemPackages = with pkgs; [
	];

	users.users.lak132.packages = with pkgs; [
		kdePackages.kate
		firefox
		discord
		spotify
		flameshot
		steam-run
		xivlauncher
	];

	# Enable CUPS to print documents.
	services.printing.enable = true;
}
