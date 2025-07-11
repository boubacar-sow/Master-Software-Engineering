# Docker Compose: Defining & Running Multi‐Container Applications
In this **Docker Compose** module, you'll learn how to define, manage, and orchestrate multi-container applications with a single YAML file. By the end, you'll be able to: 
- Install and configure Docker Compose
- Write a `docker-compose.yaml`for one or many services
- Use environment variables and override files
- Manage networks and volumes in Compose
- Scale, update, and tear down your application

---
## Prerequisites

- Completed the [Images module](../images/README.md)
- Docker Engine & Docker Compose insntalled (Compose v2+)
- Basic knowledge of YAML syntax.

---

## Part 1: Installing & Verifying Compose
Docker Compose v2 ships bundled with Docker Desktop. To verify:

```bash
docker compose version
# -> Docker Compose version v2.38.1-desktop.1
```
## Part 2: Your First docker-compose.yml
We'll start with a single service example-- an Nginx web server.

### 2.1. Directory Structure
```bash
mkdir -p docker-compose/basic
cd docker-compose/basic
```
### 2.2. Create a `docker-compose.yml`file:
```yaml
version: "3.9"          # Compose file format version
services:
  web:
    image: nginx:alpine # official Nginx image
    ports:
      - "8080:80"        # host:container
    volumes:
      - ./html:/usr/share/nginx/html:ro
```
### 2.3. Add some Static Content
```bash
mkdir html
echo "<h1>Hello from Docker Compose!</h1>" > html/index.html
```
### Launch & Test
```bash
docker compose up --build
```
- `up`: creates and starts containers
- `--build`: rebuilds images before starting

Visit http://localhost:8080 to see your page.
Stop with Ctrl+C or in another shell:
```bash
docker compose down
```
Next: [multi-service-app](multi-service-app/README.md)