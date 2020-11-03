let
  pkgs = import <nixpkgs> {}; 
in pkgs.stdenv.mkDerivation {
  pname = "iptsd";
  version = "v0.2.1";
  src = pkgs.fetchFromGitHub {
    owner = "linux-surface";
    repo = "iptsd";
    rev = "e4627e8a3a1e88b452811a1414836e9433ff89e7";
    sha256 = "17x6g4s5lnzb3s5lcvr70wdsy4qxnz026g1zwacb1275kv53sl4h";
  };
  buildInputs = with pkgs; [ meson ninja pkgconfig cmake (import ./inih.nix)];
  #mesonFlags = [ "-Ddefault_library=shared" "-Ddistro_install=true" ];
  preInstall = ''
    mkdir -p $out;
  '';
} 
