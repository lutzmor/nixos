{ config, pkgs, ... }:

{
  imports =
    [ 
      ./base/laptop.nix
      ./hosts/surface/surface.nix
      ./hardware/surface7.nix
    ];
  
  nixpkgs.config.allowUnfree = true;
  boot.loader = {
	systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
  };

  networking = {
	networkmanager.enable = true;
	useDHCP = false;
  };
  
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  sound.enable = true;

  hardware = {
	pulseaudio.enable = true;
	opengl.driSupport = true;
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
  
  virtualisation = {
	docker = {
		enable = true;
		enableOnBoot = true;
	};
  };
  
  system.stateVersion = "20.09"; # Did you read the comment?
}
