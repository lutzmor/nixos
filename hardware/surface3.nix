{ config, pkgs, ... }:
{
  imports = [
    ./surface/kernel/kernel_4_19.nix
    ./surface/surface.nix
  ];
  
  boot = {
	  blacklistedKernelModules = [ "nouveau" ];
	  initrd = {
	    kernelModules = [ "hid" "hid_sensor_hub" "i2c_hid" "hid_generic" "usbhid" "hid_multitouch" "intel_ipts" "surface_acpi" ];
	    availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
	  };
  };
}
