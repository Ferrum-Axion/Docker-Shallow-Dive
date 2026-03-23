# Legacy App Docker Practice

Containerized SSH server running on Debian, usable standalone or via Docker Compose.

## Usage

### Standalone
```bash
docker build -t ssh-server .
docker run -d -p 2222:22 ssh-server
```

### Docker Compose
```bash
docker compose up -d
```

### Connect
```bash
ssh root@localhost -p 2222
```
Password: `1234`
