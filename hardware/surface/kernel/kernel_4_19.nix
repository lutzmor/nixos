{ config, pkg, ... }:
rec {
  nixpkgs.config.packageOverrides = pkgs: {
    linux_4_19 = pkgs.linux_4_19.override {
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
        INTEL_IPTS m
        INTEL_IPTS_SURFACE m
        SERIAL_DEV_BUS y
        SERIAL_DEV_CTRL_TTYPORT y
        SURFACE_SAM m
        SURFACE_SAM_SSH m
        SURFACE_SAM_SSH_DEBUG_DEVICE y
        SURFACE_SAM_SAN m
        SURFACE_SAM_VHF m
        SURFACE_SAM_DTX m
        SURFACE_SAM_HPS m
        SURFACE_SAM_SID m
        SURFACE_SAM_SID_GPELID m
        SURFACE_SAM_SID_PERFMODE m
        SURFACE_SAM_SID_VHF m
        SURFACE_SAM_SID_POWER m
        INPUT_SOC_BUTTON_ARRAY m
        SURFACE_3_POWER_OPREGION m
        SURFACE_3_BUTTON m
        SURFACE_3_POWER_OPREGION m
        SURFACE_PRO3_BUTTON m
      '';
    };
  };
}
