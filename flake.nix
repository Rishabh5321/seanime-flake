{
  description = "Seanime service flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          seanime = pkgs.stdenv.mkDerivation rec {
            pname = "seanime";
            version = "2.7.5";

            src = pkgs.fetchurl {
              url = "https://github.com/5rahim/seanime/releases/download/v${version}/seanime-${version}_Linux_x86_64.tar.gz";
              sha256 = "sha256-Vtm+SkrUTUkVQQR4nrpc5pJXMORrBFYH4lj2R1BAFkY=";
            };

            phases = ["installPhase"];

            installPhase = ''
              mkdir -p $out/bin
              tar xzf $src -C $out/bin
            '';

            meta = {
              description = "Open-source media server with a web interface and desktop app for anime and manga";
              homepage = "https://github.com/5rahim/seanime";
              license = pkgs.lib.licenses.gpl3Only;
            };
          };
        };

        nixosModules.seanime = { config, lib, pkgs, ... }: {
          options.modules.home.services.seanime = {
            enable = lib.mkEnableOption "seanime";
          };

          config = lib.mkIf config.modules.home.services.seanime.enable {
            home.packages = [
              self.packages.${system}.seanime
            ];

            systemd.user.services.seanime = {
              Unit = {
                Description = "Seanime WebServer ";
                After = "network.service";
                X-SwitchMethod = "restart";
              };

              Install = {
                WantedBy = ["default.target"];
              };

              Service = {
                ExecStart = "${self.packages.${system}.seanime}/bin/seanime";
              };
            };
          };
        };

        defaultPackage = self.packages.${system}.seanime;
      }
    );
}