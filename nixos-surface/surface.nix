{ config, lib, pkgs, ... }:
{
  imports = [
    ./daemon/surface-iptsd-daemon-options.nix
  ];

  nixpkgs.overlays = [(self: super: {
	surface_firmware = super.callPackage ./firmware/surface-firmware.nix {};
	surface-iptsd-daemon = super.callPackage ./daemon/surface-iptsd-daemon.nix {};
	surface_kernel = super.linuxPackages_5_9.extend( self: (ksuper: {
	  kernel = ksuper.kernel.override {
	    kernelPatches = [
		{ patch = kernel/linux-surface/patches/5.9/0001-surface3-oemb.patch; name = "1"; }
		{ patch = kernel/linux-surface/patches/5.9/0002-wifi.patch; name = "2"; }
		{ patch = kernel/linux-surface/patches/5.9/0003-ipts.patch; name = "3"; }
		{ patch = kernel/linux-surface/patches/5.9/0004-surface-gpe.patch; name = "4"; }
		{ patch = kernel/linux-surface/patches/5.9/0005-surface-sam-over-hid.patch; name = "5"; }
		{ patch = kernel/linux-surface/patches/5.9/0006-surface-sam.patch; name = "6"; }
	    ];
	    extraConfig = ''
          	SERIAL_DEV_BUS y
          	SERIAL_DEV_CTRL_TTYPORT y
          	INPUT_SOC_BUTTON_ARRAY m
          	SURFACE_3_POWER_OPREGION m
          	SURFACE_3_BUTTON m
          	SURFACE_3_POWER_OPREGION m
          	SURFACE_PRO3_BUTTON m
	    '';
	  };
	}));
  })];

  hardware = {
  	firmware = [ pkgs.surface_firmware ];
  };

  boot = {
	blacklistedKernelModules = [ "surfacepro3_button" "nouveau" ];
	kernelPackages = pkgs.surface_kernel;
	initrd = {
	  kernelModules = [ "hid" "hid_sensor_hub" "i2c_hid" "hid_generic" "usbhid" "hid_multitouch" "ipts" "surface_acpi" ];
	  availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
	};
	kernelParams = [ "reboot=pci" ];
  };

  services = {
	udev.packages = [ pkgs.surface_firmware ];
	surface-iptsd-daemon = {
	  enable = true;
	};
  };
}
