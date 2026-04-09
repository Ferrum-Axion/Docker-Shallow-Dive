# SSH Legacy App 

This is a project to set up an SSH server inside a Debian Docker container.

## How to run

1. Run the setup script:
   ```bash
   bash setup.sh
   ```
2. Connect to the container:
   ```bash
   ssh -p 2222 devuser@localhost
   ```
   Password: `password123`

## Project Structure
- `Dockerfile`: Debian-based SSH server.
- `docker-compose.yml`: Container and volume setup.
- `setup.sh`: Minimal build script.
