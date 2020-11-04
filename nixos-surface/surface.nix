{ config, lib, pkgs, ... }:
{
  imports = [
    ./daemon/surface-iptsd-daemon-options.nix
  ];

  nixpkgs.overlays = [(self: super: {
	surface_firmware = super.callPackage ./firmware/surface-firmware.nix {};
	surface-iptsd-daemon = super.callPackage ./daemon/surface-iptsd-daemon.nix {};
	surface_kernel = super.callPackage ./kernel/kernel_5_9.nix {};
  })];

  hardware = {
  	firmware = [ pkgs.surface_firmware ];
  };

#  boot = {
#	blacklistedKernelModules = [ "surfacepro3_button" "nouveau" ];
#	kernelPackages = pkgs.surface_kernel;
#	initrd = {
#	  kernelModules = [ "hid" "hid_sensor_hub" "i2c_hid" "hid_generic" "usbhid" "hid_multitouch" "ipts" "surface_acpi" ];
#	  availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
#	};
#	kernelParams = [ "reboot=pci" ];
#  };

  services = {
	udev.packages = [ pkgs.surface_firmware ];
	surface-iptsd-daemon = {
	  enable = true;
	};
  };
}
