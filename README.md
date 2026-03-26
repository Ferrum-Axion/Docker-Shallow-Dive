# Docker Shallow Dive: SSH Server Container

This small project demonstrates running an SSH server inside a Docker container. It's a learning exercise for containerizing legacy services and verifying connectivity using `docker-compose` as well as standalone Docker commands.

**Included:**
- `Dockerfile` — builds a Debian-based image with `openssh-server` enabled (demo-only configuration).
- `docker-compose.yml` — simple service configuration that maps host port `2222` to container `22`.
- `setup.sh` — helper script that validates Docker, pulls base image, and runs `docker-compose up -d`.
- `TASK.md` — task description and objectives for this exercise.

## Prerequisites

- Linux (Debian/Rocky recommended)
- Docker
- Docker Compose
- git

## Quick start

1. Make the setup script executable and run it:

	```bash
	chmod +x setup.sh
	./setup.sh
	```

	The script checks for Docker and Docker Compose, pulls `debian:latest`, and brings up the container via `docker-compose`.

2. Alternatively, build and run the image manually:

	```bash
	docker build -t ssh-server-image .
	docker run -d --name ssh-server-container -p 2222:22 ssh-server-image
	```

3. Connect to the container via SSH (demo credentials — change before production):

	```bash
	ssh root@localhost -p 2222
	# password: VerySecurePassword123
	```

## Notes about the Dockerfile

- The image is based on `debian:latest` and installs `openssh-server`.


## Standalone (no docker-compose)

If you prefer to run the image directly without `docker-compose`, build the image then run with `docker run`.

Basic run (detached):

```bash
docker build -t ssh-server-image .
docker run -d --name ssh-server-container -p 2222:22 ssh-server-image
```


## Project tasks

See [TASK.md](TASK.md) for the original task specification and goals.

## Contributing

If you'd like to contribute, update [CONTRIBUTORS.md](CONTRIBUTORS.md) with your name and a short note about your contributions, and open a pull request describing your change.



