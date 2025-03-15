# NixOS NAS Configuration

A modular NixOS configuration for a Network Attached Storage (NAS) system with Docker containers, SOPS for secret management, and various services.

## Features

- Modular, maintainable NixOS configuration using Nix Flakes
- Native NixOS Docker container management

## Structure

The configuration is organized into modules:

- **System**: Core system settings
- **Services**: System services configuration
- **Containers**: Docker container settings
- **Home Manager**: User environment configuration

## Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/nixos-nas.git
cd nixos-nas

# Copy Hardware Configuration
cp /etc/nixos/hardware-configuration.nix modules/hardware/hardware-configuration.nix

# Install NixOS using the flake
sudo nixos-install --flake .#nas

# After installation, apply changes
sudo nixos-rebuild switch --flake .#nas
```

## Contributing

Feel free to fork this repository and customize it for your needs. Pull requests with improvements are welcome!

## License

MIT
