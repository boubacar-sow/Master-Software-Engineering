# Docker basics: Your first containers & Environmennt Variables
Welcome to the **Basics** module of our Docker tutorials! By the end of this guide, you’ll be able to:

- Build and run your first Docker image  
- Understand container lifecycle commands  
- Package a simple shell helper for repeatable runs  
- Define, pass, and inspect environment variables in containers  
---
## Prerequisites
- Docker Engine installed (v20.10+).
- Basic familiarity with the shell/commannd linen
- Optional: a code editor to inspect files

### Docker engine installation
Install Docker Desktop from the official website:  <https://www.docker.com/products/docker-desktop/>

- **Docker Engine** is the runtime that builds and runs containers.  
- **Docker Desktop** bundles Docker Engine with a GUI, CLI, and additional tooling (Docker Compose, Docker Machine).  
- **Docker Compose** lets you define and run multi‑container applications.  
- **Docker Machine** (optional) manages remote Docker hosts on cloud providers.
Once the application is installed, open it and then log in.
Once installed, open Docker Desktop and log in with your Docker ID.  
> **Alternative**: On Linux you can use [Podman](https://podman.io/) as a drop‑in replacement for many Docker commands.

## Part 1: Hello-World Container
### 1.1. Verify Docker is running
```bash
docker version
docker info
```
- ```docker version```: shows Client & Server versions, API version, Go version, build info, Git commit, OS/Arch, and context.
- ```docker info```: displays system-wide information: number of containers, images, storage driver, logging driver, network settings, etc

### Pull & Run the official image
>**What’s a Docker image?**
An image is a read‑only template with instructions for creating a container.

>**What’s a Docker container?**
A container is a runnable instance of an image—think of it as an isolated, lightweight VM.

(If needed) First do ```docker login```.
Then:
```bash
docker run --rm hello-world
```
- ```--rm```: cleans up the container after exit
- Docker pulls ```hello-world```(if needed), then use the ```docker run``` command. But normally, you will not need to pull it first as Docker will automatically do it if it can't find the image locally.

## Part 2: Build your own "Hello World" Image
We'll now see how to build an image that prints a custom greeting.
### 2.1 Create the Directory & Dockerfile
What's a Dockerfile? ...
```bash
mkdir hello-world
cd hello-world
```
**Dockerfile**:
```bash
# Use an official Alpine Linux base (small footprint)
FROM alpine:latest

# Set a default environment variable
ENV GREETING="Hello, I am Boubacar and I will try to show you how to start with Docker!"

# Define the command to run when the container starts
CMD ["sh", "-c", "echo \"$GREETING\""]
```
**Explanation of the content of the Dockerfile**:
- ```FROM alpine:latest```: Uses Alpine Linux as a minimal base image (~5 MB).

- ```ENV GREETING=...```: Defines a default environment variable inside the image.

- ```CMD ["sh", "-c", "..."]```: Specifies the default command executed when the container launches.
### 2.2 Build the Image
Once we have a Dockerfile, ...
```bash
docker build -t hello-custom:1.0 .
```
- ```-t hello-custom:1.0``` tags the image.
- ```.```: tells Docker to use the Dockerfile in the current directory.

### 2.3 Run & Inspect
```bash
docker run --rm hello-custom:1.0
# → Hello, I am Boubacar and I will try to show you how to start with Docker!
```

### 2.4 Delete a Docker image

## Part 2: Environment Variables
Passing vars into containers is critical for configuration
### 4.1 Defining Defaults in Dockerfile
We used:
```bash
ENV GREETING="Hello, I am Boubacar and I will try to show you how to start with Docker!"
```
This value becomes the image's default if none is supplied at runtime

### Overriding at ```docker run```
```bash
docker run --rm -e GREETING="Hello Docker professional, do you have something to show me?" hello-custom:1.0
# → Hello Docker professional, do you have something to show me?
```
### Using and ```.env``` File:
Create ```basics/hello-word/.env```:
```dotenv
GREETING="Env-file greeting!"
```
Run with:
```bash
docker run --rm --env-file .env hello-custom:1.0
# → Env-file greeting!
```
---
### Summary Table: Common Docker commands
| Command                             | Description                                                         |
| ----------------------------------- | ------------------------------------------------------------------- |
| `docker version`                    | Shows version info for client and server                            |
| `docker info`                       | Displays system-wide info about Docker setup                        |
| `docker login`                      | Authenticates with Docker Hub or registry                           |
| `docker logout`                     | Logs you out of the current Docker session                          |
| `docker run <image>`                | Runs a container from the image                                     |
| `docker run --rm <image>`           | Runs and removes container after exit                               |
| `docker build -t <name>:<tag> .`    | Builds a new image from Dockerfile in the current directory         |
| `docker images`                     | Lists all local Docker images                                       |
| `docker ps`                         | Lists running containers                                            |
| `docker ps -a`                      | Lists all containers (running + stopped)                            |
| `docker stop <container>`           | Stops a running container                                           |
| `docker rm <container>`             | Removes a stopped container                                         |
| `docker rmi <image>`                | Deletes a Docker image                                              |
| `docker exec -it <container> <cmd>` | Runs a command inside a running container (e.g., `/bin/sh`, `bash`) |
| `docker logs <container>`           | Shows logs from a container                                         |
| `docker inspect <image/container>`  | Shows detailed info in JSON format                                  |
| `docker pull <image>`               | Downloads an image from Docker Hub                                  |
| `docker tag <img> <new-name>:<tag>` | Tags an image with a new name                                       |
| `docker-compose up`                 | Starts all services defined in `docker-compose.yml`                 |
| `docker-compose down`               | Stops and removes all containers/services defined via Compose       |

---
Great, congratulations! Now you know the very basics of Docker: pulling official images, building your own and wiring environment variables. Onwards to Images, Compose and beyond!