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
		hostName = "yshtola";
		networkmanager.enable = true;
	};

	# --- time ---

	time.timeZone = "Australia/Adelaide";

	# --- graphics ---

	services.xserver = {
		enable = true;
		displayManager.sddm.enable = true;
		desktopManager.plasma5.enable = true;
		wacom.enable = true;
		videoDrivers = [ "nvidia" ];
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
