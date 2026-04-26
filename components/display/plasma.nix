{ config, pkgs, ... }:

{
	services = {
		xserver = {
			enable = true;
			xkb = {
				layout = "au";
				variant = "";
			};
		};
		displayManager.sddm.enable = true;
		desktopManager.plasma6.enable = true;
	};

	hardware.graphics.enable = true;
}
