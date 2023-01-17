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
	};

	# --- networking ---

	networking = {
		hostName = "minfilia";
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

	sound.enable = false;

	# --- software ---

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
	];

	users.users.lak132.packages = with pkgs; [
	];

	programs.nm-applet.enable = true;

	# https://nixos.wiki/wiki/Nextcloud
	services.nextcloud = {
		enable = true;
		package = pkgs.nextcloud25;
		# hostName = "localhost";
		# config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
	};
}
