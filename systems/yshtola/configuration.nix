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

	# --- bluetooth ---

	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		settings = {
			General = {
				Experimental = true;
				FastConnectable = true;
			};
			Policy = {
				AutoEnable = true;
			};
		};
	};

	services.blueman.enable = true;

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
			wacom.enable = true;
		};
		displayManager.sddm.enable = true;
		desktopManager.plasma6.enable = true;
	};

	hardware = {
		graphics.enable = true;
		nvidia.open = true; # RTX2060
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
		firefox
		discord
		spotify
		flameshot
		steam-run
		xivlauncher
	];

	# enable CUPS to print documents
	services.printing.enable = true;
}
