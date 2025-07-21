# ./seanime-pkg.nix
{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "seanime";
  version = "2.9.3";

  src = pkgs.fetchurl {
    url = "https://github.com/5rahim/seanime/releases/download/v${version}/seanime-${version}_Linux_x86_64.tar.gz";
    hash = "sha256-R245eCZ0KNFGFm2VdiAPtTrumehJIAsemlw3uEij3kU=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    tar xzf $src -C $out/bin
  '';

  meta = {
    description = "Open-source media server with a web interface and desktop app for anime and manga";
    homepage = "https://github.com/5rahim/seanime";
    license = pkgs.lib.licenses.gpl3Only;
  };
}
