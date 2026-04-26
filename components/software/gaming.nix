{ config, pkgs, ... }:

{
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};

	users.users.lak132.packages = with pkgs; [
		steam-run
		xivlauncher
	];
}
