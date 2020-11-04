{config, lib, pkgs, ... }:
{ 
  imports = [
    ./daemon/dtx/surface-dtx-daemon-options.nix
  ];

  nixpkgs.overlays = [(self: super: {
    libinput = super.callPackage ./libinput/libinput-1.15.0.nix {};
    libwacom = super.callPackage ./libwacom/surface-libwacom.nix {};
    surface-control = super.callPackage ./control/surface-control.nix {};
    surface-dtx-daemon = super.callPackage ./daemon/dtx/surface-dtx-daemon.nix {};
    surface_firmware = super.callPackage ./surface-firmware.nix {};
    surface_kernel = super.callPackage ./kernel/kerne_4_19.nix {};
  })];

  environment.systemPackages = [ pkgs.libinput ];
  hardware.firmware = [ pkgs.surface_firmware ];

  boot = {
    blacklistedKernelModules = [ "surfacepro3_button" "nouveau" ];
    kernelPackages = pkgs.surface_kernel;
    initrd = {
      kernelModules = [ "hid" "hid_sensor_hub" "i2c_hid" "hid_generic" "usbhid" "hid_multitouch" "intel_ipts" "surface_acpi" "zfs" ];
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "zfs" ];
      supportedFilesystems = [ "zfs" ];
    };
    extraModulePackages = with config.boot.kernelPackages; [ zfs ];
  };

  services.udev.packages = [ pkgs.surface_firmware pkgs.libwacom pkgs.surface-dtx-daemon ];

  services.surface-dtx-daemon = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "intel" ];
  
  powerManagement = {
    enable = true;
    #acpitool -W 2 >2 /dev/null
    powerUpCommands = ''
      source /etc/profile
      if ps cax | grep bluetoothd && ! bluetoothctl info; then
        bluetoothctl power off
      fi
    '';
    powerDownCommands = ''
      source /etc/profile
      modprobe -r ipts_surface
    '';
    resumeCommands = ''
      source /etc/profile
      if ps cax | grep bluetoothd; then
        bluetoothctl power on
      fi
      modprobe ipts_surface
    '';
  };

}
