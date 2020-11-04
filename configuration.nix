{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nixos-surface/model/surface7.nix
      ./nixos-surface/surface.nix
    ];
  
  nixpkgs.config.allowUnfree = true;
  boot.loader = {
	systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
  };

  networking = {
	hostName = "surface";
	networkmanager.enable = true;
	useDHCP = false;
	interfaces.wlp0s20f3.useDHCP = true;
  };
  
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  sound.enable = true;

  hardware = {
	pulseaudio.enable = true;
	opengl.driSupport = true;
	acpilight.enable = true;
  };

  users.users.espo = {
  	isNormalUser = true;
  	extraGroups = [ "wheel" "audio" "docker"];
  };
  
  environment = {
	systemPackages = with pkgs; [
 		wget 
    		vim
    		home-manager
		git
		acpilight
  	];
  	pathsToLink = ["/libexec"];
  };
  
  programs = {
	dconf.enable = true;
  };
  
  services = {
	openssh.enable = true;
	xserver = {
		enable = true;
		xkbOptions = "caps:swapescape";
		displayManager = {
		   lightdm.enable = true;
		   autoLogin.enable = true;
		   autoLogin.user = "espo";
		   session = [{
			manage = "desktop";
			name = "xsession";
			start = "exec $HOME/.xsession";
		   }];
		   defaultSession = "xsession";
		   job.logToJournal = true;
		};
		libinput.enable = true;
 	};
  };

  powerManagement = {
  	enable = true;
	powertop.enable = true;
	cpuFreqGovernor = "powersave";
  };
  
  virtualisation = {
	docker = {
		enable = true;
		enableOnBoot = true;
	};
  };
  
  system.stateVersion = "20.09"; # Did you read the comment?
}
