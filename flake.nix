{
  description = "ARCHIVED: Please move to https://github.com/Rishabh5321/custom-packages-flake - Seanime media server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      archiveWarning = "WARNING: This repository (seanime-flake) is being ARCHIVED. Please move to https://github.com/Rishabh5321/custom-packages-flake for future updates.";
    in
    builtins.trace archiveWarning {
      packages.x86_64-linux = {
        seanime = import ./seanime-pkg.nix {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        };
        default = self.packages.x86_64-linux.seanime;
      };

      nixosModules.seanime = { ... }: {
        imports = [
          ({ ... }: {
            imports = [ ./seanime-home.nix ];
            config = {
              warnings = [ "seanime-flake: This repository is being ARCHIVED. Please move to https://github.com/Rishabh5321/custom-packages-flake for future updates." ];
              _module.args.seanime = self.packages.x86_64-linux.seanime;
            };
          })
        ];
      };
    };
}
