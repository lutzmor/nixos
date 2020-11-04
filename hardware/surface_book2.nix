{ config, pkgs, ... }:
{
  imports = [
    ./surface/kernel/kernel_4_19.nix
    ./surface/surface-book.nix
  ];
  
  boot = {
	  blacklistedKernelModules = [ "surfacepro3_button" "nouveau" ];
	  initrd = {
	    kernelModules = [ "hid" "hid_sensor_hub" "i2c_hid" "hid_generic" "usbhid" "hid_multitouch" "ipts" "surface_acpi" ];
	    availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
	  };
  };
}
