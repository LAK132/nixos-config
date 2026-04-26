{ config, pkgs, ... }:

{
	users.users.lak132.packages = with pkgs; [
		spotify
	];
}
