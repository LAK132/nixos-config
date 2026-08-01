{ config, pkgs, ... }:

{
	users.users.lak132.packages = with pkgs; [
		gimp
		rawtherapee
		(callPackage ./rye/derivation.nix {})
	];
}
