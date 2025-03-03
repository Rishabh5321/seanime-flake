{
  description = "Seanime - Open-source media server for anime and manga";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages =
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
      in
      {
        x86_64-linux.seanime = pkgs.stdenv.mkDerivation rec {
          pname = "seanime";
          version = "2.7.5";

          src = pkgs.fetchurl {
            url = "https://github.com/5rahim/seanime/releases/download/v${version}/seanime-${version}_Linux_x86_64.tar.gz";
            sha256 = "sha256-Vtm+SkrUTUkVQQR4nrpc5pJXMORrBFYH4lj2R1BAFkY=";
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
        };
      };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.seanime;

    nixosModules.seanime = { pkgs, lib, config, ... }: {
      options.modules.home.services.seanime = {
        enable = lib.mkEnableOption "seanime";
      };

      config = lib.mkIf config.modules.home.services.seanime.enable {
        home.packages = [
          self.packages.x86_64-linux.seanime
          pkgs.mpv # Add mpv here
        ];

        systemd.user.services.seanime = {
          Unit = {
            Description = "Seanime WebServer ";
            After = "network.service";
            X-SwitchMethod = "restart";
          };

          Install = {
            WantedBy = [ "default.target" ];
          };

          Service = {
            ExecStart = "${self.packages.x86_64-linux.seanime}/bin/seanime";
            Environment = "PATH=${pkgs.mpv}/bin:${pkgs.bash}/bin:${pkgs.coreutils}/bin"; # Add mpv to PATH
          };
        };
      };
    };
  };
}
