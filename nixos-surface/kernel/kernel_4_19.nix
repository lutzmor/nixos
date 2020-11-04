{ config, pkg, ... }:
rec {
  nixpkgs.config.packageOverrides = pkgs: {
    linux_4_4 = pkgs.linux_4_4.override {
      kernelPatches = [
        { patch = linux-surface/patches/4.19/0001-surface3-power.patch; name = "1";} 
        { patch = linux-surface/patches/4.19/0002-surface3-touchscreen-dma-fix.patch; name = "2";} 
        { patch = linux-surface/patches/4.19/0003-surface3-oemb.patch; name = "3";} 
        { patch = linux-surface/patches/4.19/0004-surface-buttons.patch; name = "4"; }
        { patch = linux-surface/patches/4.19/0005-suspend.patch; name = "5"; }
        { patch = linux-surface/patches/4.19/0006-ipts.patch; name = "6"; }
        { patch = linux-surface/patches/4.19/0007-wifi.patch; name = "7"; }
        { patch = linux-surface/patches/4.19/0008-surface-gpe.patch; name = "8"; }
        { patch = linux-surface/patches/4.19/0009-surface-sam-over-hid.patch; name = "9"; }
        { patch = linux-surface/patches/4.19/0010-surface-sam.patch; name = "10"; }
      ];
      extraConfig = ''
        I2C_DESIGNWARE_PLATFORM m
        X86_INTEL_LPSS y
      '';
    };
  };
}
