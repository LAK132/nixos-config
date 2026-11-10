{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		git
		gcc
		meson
		cmake
		python3
		usbutils
		fastfetch
		wine
		rustup
	];

	users.users.lak132.packages = with pkgs; [
		winetricks
		gparted
		(vscode.overrideAttrs (old: {
			# https://github.com/NixOS/nixpkgs/issues/584492
			# rm: cannot remove 'resources/app/node_modules/@vscode/ripgrep/bin/rg': No such file or directory
			postPatch = builtins.replaceStrings
				[ "resources/app/node_modules/@vscode/ripgrep/bin/rg" ]
				[ "resources/app/node_modules/@vscode/ripgrep-universal/bin/linux-x64/rg" ]
				old.postPatch;
		}))
		clang-tools # clang-format
		ddd
		(callPackage ./binex/derivation.nix {})
		(callPackage ./lak/derivation.nix {})
	];
}
