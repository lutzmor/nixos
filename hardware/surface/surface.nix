{ config, lib, pkgs, ... }:
{
  imports = [
    ./daemon/iptsd/surface-iptsd-daemon-options.nix
  ];

  nixpkgs.overlays = [(self: super: {
	surface_firmware = super.callPackage ./firmware/surface-firmware.nix {};
	surface-iptsd-daemon = super.callPackage ./daemon/iptsd/surface-iptsd-daemon.nix {};
	surface_kernel = super.callPackage ./kernel/kernel_5_9.nix {};
  })];
  
  boot = {
  	kernelPackages = pkgs.surface_kernel;
  };
  
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
