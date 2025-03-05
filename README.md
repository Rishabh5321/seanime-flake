# Seanime Flake

[![NixOS](https://img.shields.io/badge/NixOS-supported-blue.svg)](https://nixos.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![flake_check](https://github.com/Rishabh5321/seanime-flake/actions/workflows/flake_check.yml/badge.svg)](https://github.com/Rishabh5321/seanime-flake/actions/workflows/flake_check.yml)

This repository provides a Nix flake for [Seanime](https://github.com/5rahim/seanime), an open-source media server with a web interface and desktop app for anime and manga. The flake includes the Seanime server and a NixOS module for easy integration into Home Manager configuration.

## Table of Contents
1. [Features](#features)
2. [Installation](#installation)
   - [Using the Flake Directly](#using-the-flake-directly)
   - [Integrating with Home Manager](#integrating-with-home-manager)
3. [Configuration](#configuration)
4. [Troubleshooting](#troubleshooting)
5. [Contributing](#contributing)
6. [License](#license)

---

## Features
- **Pre-built Seanime Package**: The flake provides a pre-built Seanime package for `x86_64-linux`.
- **NixOS Module**: Easily enable Seanime as a systemd user service with the included NixOS module.
- **Dependency Management**: Automatically handles dependencies like `mpv` for video playback.

---

## Installation

### Using the Flake Directly
You can run Seanime directly using the flake without integrating it into your NixOS configuration:

```bash
nix run github:rishabh5321/seanime-flake
```
### Using the Flake Profiles

You can install Seanime directly using the flake without integrating it into your NixOS configuration:
```bash
nix profile install github:rishabh5321/seanime-flake#seanime
```
Then to start the app use `seanime` or run seanime in terminal

### Integrating with Home Manager 

Currently home-manager is necessary for having for building the server as this flake creates a service for user not system.

1. Add the seanime flake to your flake.nix inputs.
```nix
seanime.url = "github:rishabh5321/seanime-flake";
```
2. Import the seanime module in your NixOS configuration in home.nix:
```nix
{ inputs, ... }: {
   imports = [
      inputs.seanime.nixosModules.seanime # import this in home.nix
   ];
}
```
3. Enable seanime module in home.nix
```nix
modules.home.services.seanime.enable = true;
```
4. Rebuild your system:
```bash
sudo nixos-rebuild switch --flake .#<your-hostname>
```
OR
```bash
nh os boot --hostname <your-hostname> <your-flake-dir>
```
5. Start the Seanime service:
```bash
systemctl --user start seanime
```

### Configuration

The seanime flake provides the following options:

NixOS Module Options:

`modules.home.services.seanime.enable:` Enable or disable the Seanime service.

### Example Configuration

Here’s an example of how to configure Seanime in your NixOS configuration: (In home.nix)

```nix
{ config, pkgs, inputs, ... }: # this is for home.nix

{
  imports = [
    inputs.seanime.nixosModules.seanime
  ];

  modules.home.services.seanime.enable = true;
}
```

### Troubleshooting

`mpv` Not Found

If Seanime fails to play videos with the error `exec: "mpv": executable file not found in $PATH`, ensure that `mpv` is installed and available in the `$PATH`. You can add `mpv` to your system or user packages:

#### System-Wide Installation:

Add `mpv` to `environment.systemPackages` in your NixOS configuration:
```nix
environment.systemPackages = with pkgs; [
  mpv
];
```

#### User-Specific Installation
Add `mpv` to `home.packages` in your Home Manager configuration:
```nix
home.packages = with pkgs; [
  mpv
];
```

#### Service Not Starting
If the Seanime service fails to start, check the logs for more details:
```bash
journalctl --user -u seanime -f
```

### Contributing

Contributions to this flake are welcome! Here’s how you can contribute:
1. Fork the repository.
2. Create a new branch for your changes:
```bash
git checkout -b my-feature
```
3. Commit your changes:
```bash
git commit -m "Add my feature"
```
4. Push the branch to your fork:
```bash
git push origin my-feature
```
5. Open a pull request on GitHub.

### License
This flake is licensed under the MIT License. Seanime itself is licensed under the GPL-3.0 License.

### Acknowledgments

## Acknowledgments
- [Seanime](https://github.com/5rahim/seanime) by 5rahim for the amazing media server.
- [Th4tGuy69](https://github.com/Th4tGuy69) for their [NixOS configuration](https://github.com/Th4tGuy69/nixos-config) that inspired parts of this flake.
- [70705](https://github.com/70705) for their [flake setup](https://github.com/70705/nixconfig) that helped streamline this project.
- The NixOS community for their support and resources.
