{ config, pkgs, ... }:
{
  hardware = {
    acpilight.enable = true;
  };
  
  powerManagement = {
	enable = true;
	powertop.enable = true;
	cpuFreqGovernor = "powersave";
  };

  environment = {
	systemPackages = with pkgs; [
		acpilight
	];
  };
}
