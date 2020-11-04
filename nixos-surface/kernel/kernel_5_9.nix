{ config, pkg, ... }:
rec {
  nixpkgs.config.packageOverrides = pkgs: {
    linux_5_9 = pkgs.linux_5_9.override {
      kernelPatches = [
        { patch = linux-surface/patches/5.9/0001-surface3-oemb.patch; name = "1"; }
		    { patch = linux-surface/patches/5.9/0002-wifi.patch; name = "2"; }
		    { patch = linux-surface/patches/5.9/0003-ipts.patch; name = "3"; }
		    { patch = linux-surface/patches/5.9/0004-surface-gpe.patch; name = "4"; }
		    { patch = linux-surface/patches/5.9/0005-surface-sam-over-hid.patch; name = "5"; }
		    { patch = linux-surface/patches/5.9/0006-surface-sam.patch; name = "6"; }
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
  };
}
