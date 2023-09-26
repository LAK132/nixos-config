{ config, pkgs, ... }:

{
	imports = [
		../lak132/user.nix
		../lak132/dev.nix
	];

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
		networkmanager.enable = true;
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
