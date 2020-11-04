{ config, lib, pkgs, ... }:
{
  imports = [
    ./daemon/iptsd/surface-iptsd-daemon-options.nix
  ];

  nixpkgs.overlays = [(self: super: {
	surface_firmware = super.callPackage ./firmware/surface-firmware.nix {};
	surface-iptsd-daemon = super.callPackage ./daemon/iptsd/surface-iptsd-daemon.nix {};
  })];
  
  hardware = {
  	firmware = [ pkgs.surface_firmware ];
  };

  services = {
	udev.packages = [ pkgs.surface_firmware ];
	surface-iptsd-daemon = {
	  enable = true;
	};
  };
}
