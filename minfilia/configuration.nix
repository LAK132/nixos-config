{ config, pkgs, ... }:

{
	# --- boot ---

	boot = {
		kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
		supportedFilesystems = [ "zfs" ];
		zfs.extraPools = [ "data1" ];
	};

	# --- networking ---

	networking = {
		hostName = "minfilia";
		hostId = (builtins.substring 0 8 (builtins.readFile "/etc/machine-id"));
		networkmanager.enable = true;
		firewall.enable = true;
		firewall.allowPing = true;
		firewall.allowedTCPPorts = [ 
			23
			80
			443
			5357 # wsdd
			445 139
			8334 # filebrowser
		];
		firewall.allowedUDPPorts = [
			3702 # wsdd
			137 138
		];
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
		docker-compose
	];

	users.users.lak132.packages = with pkgs; [
		firefox
	];

	users.extraGroups.docker.members = [ "lak132" ];

	programs.nm-applet.enable = true;

	services.zfs.autoScrub.enable = true;

	virtualisation.arion = {
		backend = "docker";
		projects.nginx-hosting.settings = {
			services = {
				nginx-proxy-manager.service = {
					image = "jc21/nginx-proxy-manager:latest";
					volumes = [
						"/home/lak132/nginx/data:/data"
						"/home/lak132/nginx/letsencrypt:/etc/letsencrypt"
					];
					ports = [
						"80:80"
						"443:443"
						"81:81"
					];
				};
				filebrowser.service = {
					image = "filebrowser/filebrowser:latest";
					volumes = [
						"/mnt/nas:/srv"
						"/home/lak132/filebrowser/database:/database"
						"/home/lak132/filebrowser/config:/config"
					];
					ports = [
						"8334:80"
					];
				};
			};
		};
	};

	services.nextcloud = {
		enable = false;
		package = pkgs.nextcloud27;
		maxUploadSize = "10G";
		datadir = "/mnt/nextcloud/data";
		# hostName = "localhost";
		# https = true;
		config = {
			# adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
			dbtype = "pgsql";
			dbuser = "nextcloud";
			dbhost = "/run/postgresql";
			dbname = "nextcloud";
		};
		extraOptions = {
			"bulkupload.enabled" = true;
		};
		caching.redis = true;
		configureRedis = true;
	};

	services.postgresql = {
		enable = true;
		package = pkgs.postgresql_13;
		dataDir = "/mnt/postgres/database";
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

	services.samba-wsdd.enable = true; # make shared visible for Win10 clients
	services.samba = {
		enable = true;
		enableNmbd = true;
		enableWinbindd = true;
		openFirewall = true;
		securityType = "user";
		extraConfig = ''
			workgroup = WORKGROUP
			server string = MINFILIA
			server role = standalone
			netbios name = MINFILIA
			security = user
			#user sendfile = yes
			min protocol = smb2
			# max protocol = smb3
			# note: localhost is the ipv6 localhost ::1
			hosts allow = 192.168.0.0/16 127.0.0.1 localhost
			hosts deny = 0.0.0.0/0
			guest account = nobody
			map to guest = bad user
			# map to guest = never
			# valid users = lak132, nobody
		'';
		shares = {
			Public = {
				path = "/mnt/nas/Public";
				browseable = "yes";
				"read only" = "no";
				"guest ok" = "yes";
				"create mask" = "0644";
				"directory mask" = "0755";
			};
			LAK132 = {
				path = "/mnt/nas/LAK132";
				browseable = "yes";
				"read only" = "no";
				"guest ok" = "no";
				"create mask" = "0644";
				"directory mask" = "0755";
			};
		};
	};
}
