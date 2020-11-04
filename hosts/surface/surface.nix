{ config, pkgs, ... }:
{
  imports = [
    ./configuration.nix
  ];

  networking = {
	hostName = "surface";
	interfaces.wlp0s20f3.useDHCP = true;
  };
}
