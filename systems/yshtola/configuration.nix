{ config, pkgs, ... }:

{
	# --- boot ---

	boot = {
		supportedFilesystems = [ "ntfs" ];
		binfmt.emulatedSystems = [ "aarch64-linux" ];
	};

	fileSystems."/mnt/minfilia" = {
		device = "lak132@minfilia.lan:/mnt/nas";
		fsType = "sshfs";
		options = [
			"allow_other"
			"noatime"
			"_netdev"
			"x-systemd.automount"
			"reconnect"
			"ServerAliveInterval=15"
			"IdentityFile=/var/secrets/minfilia_id_rsa"
		];
	};

	# --- networking ---

	networking = {
		hostName = "yshtola";
		networkmanager.enable = true;
	};

	# --- time ---

	time.timeZone = "Australia/Adelaide";

	# --- hardware ---

	services.xserver = {
		videoDrivers = [ "nvidia" ];
		wacom.enable = true;
	};

	services.udev.extraRules = ''
		# sony devices
		SUBSYSTEM=="usb", ATTR{idVendor}=="054c", MODE="0666"
	'';

# environment.systemPackages = with pkgs; [
#   (xivlauncher.overrideAttrs (oldAttrs: {
#     postInstall = (oldAttrs.postInstall or "") + ''
#       wrapProgram $out/bin/xivlauncher \
#         --set SDL_GAMECONTROLLERCONFIG "YOUR_COPIED_MAPPING_STRING_HERE"
#     '';
#   }))
# ];

# 0000a53e5e040000120b000000000000,Xbox Series X Controller,a:b0,b:b1,x:b2,y:b3,back:b8,guide:b10,start:b9,leftstick:b11,rightstick:b12,leftshoulder:b4,rightshoulder:b5,dpup:b13,dpdown:b14,dpleft:b15,dpright:b16,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:a2,righttrigger:a5,platform:Linux,

	services.gnome.glib-networking.enable = true;

	services.hardware.bolt.enable = true;

	hardware.nvidia.open = true; # RTX2060

	# --- software ---

	nixpkgs.config.allowUnfree = true;

	programs.virt-manager.enable = true;

	users.groups.libvirtd.members = [ "lak132" ];
	users.users.lak132.extraGroups = [ "libvirtd" ];

	virtualisation.libvirtd.enable = true;

	virtualisation.spiceUSBRedirection.enable = true;

	# enable CUPS to print documents
	services.printing.enable = true;
}
