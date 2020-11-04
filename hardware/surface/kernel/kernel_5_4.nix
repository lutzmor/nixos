{ config, pkg, ... }:
rec {
  nixpkgs.config.packageOverrides = pkgs: {
    linux_5_4 = pkgs.linux_5_4.override {
      kernelPatches = [
        { patch = linux-surface/patches/5.4/0001-surface3-power.patch; name = "1";} 
        { patch = linux-surface/patches/5.4/0002-surface3-oemb.patch; name = "2";} 
        { patch = linux-surface/patches/5.4/0003-wifi.patch; name = "3";} 
        { patch = linux-surface/patches/5.4/0004-ipts.patch; name = "4"; }
        { patch = linux-surface/patches/5.4/0005-surface-gpe.patch; name = "5"; }
        { patch = linux-surface/patches/5.4/0006-surface-sam-over-hid.patch; name = "6"; }
        { patch = linux-surface/patches/5.4/0007-surface-sam.patch; name = "7"; }
      ];
      extraConfig = ''
        I2C_DESIGNWARE_PLATFORM m
        X86_INTEL_LPSS y
      '';
    };
  };
}
