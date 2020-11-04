{ config, pkgs, ... }:
{
  networking = {
	hostName = "surface";
	interfaces.wlp0s20f3.useDHCP = true;
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
}
