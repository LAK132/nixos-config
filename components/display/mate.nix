{ config, pkgs, ... }:

{
	services = {
		xserver = {
			enable = true;
			xkb = {
				layout = "au";
				variant = "";
			};
			displayManager.lightdm.enable = true;
			desktopManager.mate.enable = true;
		};
	};

	hardware.graphics.enable = true;

	environment.systemPackages = with pkgs; [
		flameshot
	];
}
