## Part 1: Simple Node.js App Image

---
Welcome! In this tutorial, we’ll build, run, inspect, and share containerized applications using Docker. Each step includes explanations so you understand **what** you’re doing and **why** it matters.

### 1.1 Create the App
```bash
mkdir -p images/simple-node         # assuming you are in the containerization directory
cd images/simple-node
```
Create an ```app.js```file and write in it the following:
```js
// images/simple-node/app.js
const http = require('http');
const PORT = process.env.PORT || 3000;

const server = http.createsERVER((req, res) => {
    res.end("Hello from Dockerized Node.js!");
});

server.listen(PORT, () => {
    console.log("Server running on port ${PORT}");
});
```
**Explanation**:

- We import Node’s built‑in ```http``` module to create a minimal web server.
- ```process.env.PORT || 3000``` lets us override the port at runtime (flexibility).
- ```createServer``` and ```listen``` start the server.

### 1.2 Write the Dockerfile
Create a Dockerfile (The dockerfile has no extension and is name ```Dockerfile```):
```dockerfile
# Use official Node.js LTS slim image
FROM node:18-slim

# Create app directory inside container
WORKDIR /usr/src/app

# Copy package.json & package-lock.json (none here)
# (If you had dependencies, you'd COPY and run npm install)
# COPY package*.json ./
# RUN npm install

# Copy application code
COPY app.js ./

# Expose port
EXPOSE 3000

# Default command
CMD ["node", "app.js"]
```
>**Explanation**:
```FROM node:18-slim```: picks a smaller Debian-based Node image.
```WORKDIR```: sets the working directory for subsequent commands.
```COPY app.js ./```: copies code into the image.
```EXPOSE 3000```: documents the port, doesn't actually publish it.
```CMD ["node", "app.js"]```: tells Docker how to start the app.

### Build & Tag
```bash
docker build -t boubacar-sow/simple-node:1.0 . # yourhubusername/simple-node:1.0 .
```
- ```-t```: tags as ```yourhubusername/simple-node```with tag ```1.0````
- Use your actual Docker Hub username to avoid conflicts.

### 1.4 Run & Test
```bash
docker run -rm -p 3000:3000 boubacar-sow/simple-node:1.0
```
- ```-p 3000:3000```maps container port 3000 to your host
- Visit http://localhost:3000 to see "Hello from Dockerized Node.js!"
Stop the container with ```Ctrl+c```.

## Part 2/ Inspecting Layers & Caching
Docker builds images in layers, one per instruction. Layers are cached, so unchanged steps are skipped on rebuild, speeding up development.

```plaintext
Dockerfile Instructions
+------------------------------------------------+
| 1. FROM node:18-slim                           |
| 2. COPY package.json ./                        |
| 3. RUN npm install                             |
| 4. COPY app.js ./                              |
| 5. EXPOSE 3000                                 |
| 6. CMD ["node","app.js"]                       |
+------------------------------------------------+
                    │
                    ▼
Layer Build & Cache Check
+------------------------------------------------+
| Layer # | Instruction         | Cache Status    |
|---------|---------------------|-----------------|
|   1     | FROM node:18-slim   | (cache hit)     |
|   2     | COPY package.json   | (cache hit)     |
|   3     | RUN npm install     | (cache miss → new build) |
|   4     | COPY app.js         | (cache hit)     |
|   5     | EXPOSE 3000         | (cache hit)     |
|   6     | CMD ["node","app.js"] | (cache hit)   |
+------------------------------------------------+

Rebuild Workflow:
1. Docker reads instruction 1 → finds cached layer → reuses it  
2. Instruction 2 → cached → reused  
3. Instruction 3 → cache invalid (package.json changed? or new image) → rebuild layer  
4. Instructions 4–6 → unchanged → reused from cache  

**Key:**  
- **cache hit** = layer reused, no rebuild  
- **cache miss** = layer rebuilt, subsequent layers invalidated  
```
### 2.1 View History
```bash
docker history boubacar-sow/simple-node:1.0             # yourhubusername/simple-node:1.0
```
You'll see each layer's size and creation command. Changing a file early in the Dockerfile invalidates subsequent layers' cache.

```plaintext
bsow@ML25-1021 simple-node % docker history boubacar-sow/simple-node:1.0
IMAGE          CREATED             CREATED BY                                      SIZE      COMMENT
23aad6e7b190   About an hour ago   CMD ["node" "app.js"]                           0B        buildkit.dockerfile.v0
<missing>      About an hour ago   EXPOSE map[3000/tcp:{}]                         0B        buildkit.dockerfile.v0
<missing>      About an hour ago   COPY app.js ./ # buildkit                       20.5kB    buildkit.dockerfile.v0
<missing>      About an hour ago   WORKDIR /usr/src/app                            16.4kB    buildkit.dockerfile.v0
```
**Why inspect layers?**
- To understand which instructions generate large layers.
- To optimize Dockerfile order so that frequently changing files come after stable instructions, maximizing cache reuse.

### 2.2 Practice: Add a Dependency
1. Create a ```package.json```:
```json
{
    "name":"simple-node",
    "version":"1.0.0",
    "main":"app.js",
    "license": "MIT",
    "dependencies": {
        "express": "^4.18.2"
    }
}
**Explanation**:
- Defines project metadata and declares express as a runtime dependency.
- Docker can install only what’s in ```dependencies``` (not ```devDependencies```), keeping images slim.
```
2. Update ```Dockerfile```:
```dockerfile
FROM node:18-slim
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install --only=production
COPY app.js ./
EXPOSE 3000
CMD ["node", "app.js"]
```
**Explanation**:
- ```COPY package.json ./``` and then ```RUN npm install```: Lets Docker cache the install step if package.json is unchanged.
- Copying ```app.js``` last means code changes don’t invalidate the heavy ```npm install``` layer.

3. Rebuild:
```bash
docker build -t boubacar-sow/simple-node:2.0 .
```
4. Notice in ```docker history```that only the layers after ```COPY package.json```changed if you didn't touch ```app.js```

