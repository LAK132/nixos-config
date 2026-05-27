{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
		components.url = ./../../components;
	};

	outputs = { self, nixpkgs, components }: {
		config = args: nixpkgs.lib.nixosSystem (args // {
			system = "x86_64-linux";
			modules = args.modules ++ [
				{nixpkgs.overlays = [
					(_: prev: {
						openldap = prev.openldap.overrideAttrs {
							# https://github.com/NixOS/nixpkgs/issues/513245
							doCheck = !prev.stdenv.hostPlatform.isi686;
						};
					})
				];}
				./configuration.nix
				components.lak132
				components.display.plasma
				components.hardware.bluetooth
				components.hardware.sound
				components.software.dev
				components.software.gaming
				components.software.internet
				components.software.media
				components.software.social
			];
		});
	};
}
