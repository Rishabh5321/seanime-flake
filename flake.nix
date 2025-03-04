# flake.nix
{
  description = "Seanime - Open-source media server for anime and manga";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.seanime =
      import ./seanime-pkg.nix {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.seanime;

    nixosModules.seanime = { ... }: {
      imports = [ ./seanime-home.nix ];
    };
  };
}