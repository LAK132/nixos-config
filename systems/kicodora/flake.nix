{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
		components.url = ./../../components;
		mobile-nixos = {
			url = "github:LAK132/mobile-nixos/f297850d2a025f52e0102aa5b19730b842d64919";
			flake = false;
		};
	};

	outputs = { self, nixpkgs, components, mobile-nixos }: {
		config = args: nixpkgs.lib.nixosSystem (args // {
			system = "aarch64-linux";
			modules = args.modules ++ [
				(import "${mobile-nixos}/lib/configuration.nix" {
					device = "pine64-pinephone";
				})
				./configuration.nix
				"${mobile-nixos}/examples/phosh/phosh.nix"
				"${mobile-nixos}/examples/common-configuration.nix"
				components.lak132
			];
		});
	};
}
