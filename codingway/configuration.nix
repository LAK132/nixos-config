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
	};

	# --- time ---

	time.timeZone = "Australia/Adelaide";

	# --- graphics ---

	services.xserver = {
		enable = true;
		xkb = {
			layout = "au";
			variant = "";
		};
		displayManager.lightdm.enable = true;
		desktopManager.mate.enable = true;
	};

	hardware.graphics.enable = true;

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

	environment.systemPackages = with pkgs; [
	];

	users.users.lak132.packages = with pkgs; [
		firefox
		flameshot
	];

	# enable CUPS to print documents
	services.printing.enable = true;
}
