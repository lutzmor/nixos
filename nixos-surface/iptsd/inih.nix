let
  pkgs = import <nixpkgs> {}; 
in pkgs.stdenv.mkDerivation {
  pname = "inih";
  version = "r52";
  src = pkgs.fetchFromGitHub {
    owner = "benhoyt";
    repo = "inih";
    rev = "r52";
    sha256 = "sha256-pIaDvCxAY9r5UiutUStI66PC3v7L19hpD3Ev9cmoW1M=";
  };
  buildInputs = with pkgs; [ meson ninja];
  mesonFlags = [ "-Ddefault_library=shared" "-Ddistro_install=true" ];
  preInstall = ''
    mkdir -p $out;
  '';
} 
