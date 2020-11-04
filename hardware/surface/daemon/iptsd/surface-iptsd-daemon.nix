let
  pkgs = import <nixpkgs> {}; 
in pkgs.stdenv.mkDerivation {
  name = "surface-iptsd-daemon";
  version = "v0.2.1";
  src = pkgs.fetchFromGitHub {
    owner = "linux-surface";
    repo = "iptsd";
    rev = "e4627e8a3a1e88b452811a1414836e9433ff89e7";
    sha256 = "17x6g4s5lnzb3s5lcvr70wdsy4qxnz026g1zwacb1275kv53sl4h";
  };
  
  patches = [ patches/service.patch ];

  buildInputs = with pkgs; [ meson ninja pkgconfig cmake (import ./libinih/inih.nix)];

  preInstall = ''
    mkdir -p $out;
  '';

  postInstall = ''
    mkdir -p $out/etc/udev/rules.d
    cp etc/udev/50-ipts.rules $out/etc/udev/rules.d/

    mkdir -p $out/etc/systemd/system
    cp etc/systemd/iptsd.service
  '';
} 
