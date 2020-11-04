{ config, pkg, ... }:
rec {
  nixpkgs.config.packageOverrides = pkgs: {
    linux_5_8 = pkgs.linux_5_8.override {
      kernelPatches = [
        { patch = linux-surface/patches/5.8/0001-surface3-oemb.patch; name = "1";} 
        { patch = linux-surface/patches/5.8/0002-wifi.patch; name = "2";} 
        { patch = linux-surface/patches/5.8/0003-ipts.patch; name = "3";} 
        { patch = linux-surface/patches/5.8/0004-surface-gpe.patch; name = "4"; }
        { patch = linux-surface/patches/5.8/0005-surface-sam-over-hid.patch; name = "5"; }
        { patch = linux-surface/patches/5.8/0006-surface-sam.patch; name = "6"; }
      ];
      extraConfig = ''
        I2C_DESIGNWARE_PLATFORM m
        X86_INTEL_LPSS y
      '';
    };
  };
}
