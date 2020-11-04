{ config, pkg, ... }:
rec {
  nixpkgs.config.packageOverrides = pkgs: {
    linux_4_4 = pkgs.linux_4_4.override {
      kernelPatches = [
        { patch = ./multitouch.patch; name = "multitouch-type-cover";} 
        { patch = ./touchscreen_multitouch_fixes1.patch; name = "multitouch-fixes1";} 
        { patch = ./touchscreen_multitouch_fixes2.patch; name = "multitouch-fixes2";} 
        { patch = ./cam.patch; name = "surfacepro3-cameras"; }
      ];
      extraConfig = ''
        I2C_DESIGNWARE_PLATFORM m
        X86_INTEL_LPSS y
      '';
    };
  };
}
