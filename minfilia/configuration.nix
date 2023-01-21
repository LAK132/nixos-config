{ config, pkgs, ... }:

{
	imports = [
		../lak132/user.nix
		../lak132/dev.nix
	];

	# --- boot ---

	boot = {
		kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
		loader = {
			systemd-boot.enable = true;
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot/efi";
			};
		};
		supportedFilesystems = [ "zfs" ];
		zfs.extraPools = [ "data1" ];
	};

	# --- networking ---

	networking = {
		hostName = "minfilia";
		hostId = (builtins.substring 0 8 (builtins.readFile "/etc/machine-id"));
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

	sound.enable = false;

	# --- software ---

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		zfs
	];

	users.users.lak132.packages = with pkgs; [
	];

	programs.nm-applet.enable = true;

	services.zfs.autoScrub.enable = true;

	services.nextcloud = {
		enable = true;
		package = pkgs.nextcloud25;
		maxUploadSize = "10G";
		# hostName = "localhost";
		# https = true;
		config = {
			# adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
			dbtype = "pgsql";
			dbuser = "nextcloud";
			dbhost = "/run/postgresql";
			dbname = "nextcloud";
		};
	};

	services.postgresql = {
		enable = true;
		package = pkgs.postgresql_13;
		dataDir = "/mnt/nextcloud/database";
		ensureDatabases = [ "nextcloud" ];
		ensureUsers = [
			{
				name = "nextcloud";
				ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
			}
		];
	};

	systemd.services."nextcloud-setup" = {
		requires = [ "postgresql.service" ];
		after = [ "postgresql.service" ];
	};
}
