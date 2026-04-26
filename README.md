# Installation

1. Add the following to `/etc/nixos/configuration.nix`:
```nix
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	environment.systemPackages = with pkgs; [
		git
	];
```

2. `nixos-rebuild test`

3. Create `/etc/nixos/flake.nix`:
```nix
{
	inputs.nixos-config.url = "github:LAK132/nixos-config";

	outputs = { self, nixpkgs, nixos-config }: {
		nixosConfigurations = nixos-config.nixosConfigurations ({
			modules = [ ./configuration.nix ];
		});
	};
}
```

4. Remove content of `/etc/nixos/configuration.nix` until it looks like:
```nix
{ config, pkgs, ... }:

{
	imports =
		[
			# Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "22.11"; # Did you read the comment?
}

```

5. `nixos-rebuild switch`

# Tips

Use `inputs.nixos-config.url = "github:LAK132/nixos-config/dev";` for dev branch.

Use `inputs.nixos-config.url = "git+file:/home/lak132/repos/nixos-config?branch=dev";` for local clone of dev branch.

Use `nixos-rebuild switch --flake "/etc/nixos#XYZW"` to change to the configuration for `XYZW`.

Use `nix flake update nixos-config` in `/etc/nixos` to update the lock file.

The computer must use UEFI boot in order to use systemd-boot
