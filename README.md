# akuse for NixOS

This repository contains a Nix flake for packaging akuse, Simple and easy to use anime streaming desktop app without ads.

## Table of Contents

1. [About akuse](#about-akuse)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Version Management](#version-management)
5. [Contributing](#contributing)
6. [License](#license)

## About akuse

Simple and easy to use anime streaming desktop app without ads.

For more information about akuse, visit the [official website](https://github.com/akuse-app/akuse/).

## Installation

You can install akuse via nix profile command like this
  ```nix
  nix profile install "github:Rishabh5321/akuse-flake#akuse"
  ```

OR You can use flakes if you want declarative config.

To install akuse using this flake, follow these steps:

1. Ensure you have flakes enabled in your NixOS configuration.

2. Add this flake to your `flake.nix`:

   ```nix
   {
     inputs = {
       nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Note that nixos unstable channel is required
       akuse-flake.url = "github:Rishabh5321/akuse-flake";
     };

     outputs = { self, nixpkgs, akuse-flake }: {
       # Your existing configuration...
       
       nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
         # ...
         modules = [
           # Add inputs.akuse-flake.packages.${system}.akuse to your pkgs file
           ({ pkgs, ... }: {
             environment.systemPackages = [ inputs.akuse-flake.packages.${system}.akuse ];
           })
         ];
       };
     };
   }
   ```

3. Run `sudo nixos-rebuild switch` to apply the changes. It can also be registered with home manager

## Usage

After installation, you can launch akuse from your application menu or by running `akuse` in your terminal.

## Version Management

To ensure proper version management and take full advantage of Nix's reproducibility features, we recommend the following:

1. **Update using Nix**:
   To update akuse, update the flake input in your `flake.nix` and rebuild your system:

   ```sh
   nix flake update
   sudo nixos-rebuild switch
   ```

This approach ensures that your akuse version is managed atomically with the rest of your system, providing better stability and reproducibility.

## Contributing

We welcome contributions to improve this Nix package for akuse! Here are some ways you can contribute:

1. **Testing**: Try the package on different NixOS configurations and report any issues.
2. **Documentation**: Help improve this README or add wiki pages with tips and tricks.
3. **Code Improvements**: Suggest improvements to the Nix expression or flake configuration.
4. **Version Updates**: Help keep the package up-to-date with the latest akuse releases.

To contribute:

1. Fork this repository
2. Create a new branch for your changes
3. Make your changes and commit them
4. Push to your fork and submit a pull request

---

For any questions or issues, please open an issue on the GitHub repository.
