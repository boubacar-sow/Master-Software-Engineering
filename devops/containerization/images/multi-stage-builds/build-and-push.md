## Part 3: Multi-Stage Builds
Multi‑stage builds let you compile or build artifacts in one stage, then copy only the result into a smaller final image—great for compiled languages.

### 3.1. Sample Go App

For demonstration, let’s pretend we have a simple Go app:
```go
// images/multi-stage-builds/main.go
package main

import "fmt"

func main() {
    fmt.Println("Hello from Go multi-stage build!")
}
```

### Dockerfile

Create images/multi-stage-builds/Dockerfile:

```dockerfile
# Build stage — updated to Go 1.24
FROM golang:1.24.4-alpine AS builder
WORKDIR /src
# Copy go.mod and go.sum if present
COPY go.mod ./
# (Optional but useful if go.sum exists)
# COPY go.sum ./
# Download dependencies
RUN go mod tidy
# Copy app code
COPY main.go ./
# Build the binary
RUN go build -o app

# Final image
FROM alpine:latest
WORKDIR /app
COPY --from=builder /src/app .
CMD ["./app"]

```
**Explanation**

- Stage 1 (builder): Uses the full Go SDK to compile ```main.go``` into a static binary named ```app```.
- Stage 2: Starts from tiny Alpine, copies only the compiled binary, and discards all build tools.
- Final image is minimal: no Go runtime, only your app (~6 MB).

### 3.3. Build & Run
(Optionally) Install Go and run ```go mod init github.com/boubacar-sow/go-multi```
```bash
cd images/multi-stage-builds
docker build -t yourhubusername/go-multi:1.0 .
docker run --rm yourhubusername/go-multi:1.0
# → Hello from Go multi-stage build!
```

## Part 4: Pushing & Pulling to a Registry
### 4.1. Log In

```docker login```

Enter your Docker Hub credentials.

### 4.2. Push Your Image
```bash
docker push yourhubusername/simple-node:1.0
docker push yourhubusername/go-multi:1.0
```

Verify on Docker Hub’s website under your repositories.
### 4.3. Pull & Run Elsewhere

On another machine or after pruning local images:
```bash
docker rmi yourhubusername/simple-node:1.0
docker pull yourhubusername/simple-node:1.0
docker run --rm -p 3000:3000 yourhubusername/simple-node:1.0
```


## Part 5: Tagging Best Practices
- Use semantic versioning: ```1.0.0```, ```1.0.1```, etc.
- ```latest``` tag: A convenient alias for the most recent stable version:
```bash
docker tag yourhubusername/simple-node:1.0 yourhubusername/simple-node:latest
docker push yourhubusername/simple-node:latest
```
- **Immutable tags**: Once pushed, avoid reusing the same tag for different images—helps traceability in production.

**Pas facile/Not easy, mais j'espère que tu as tenu jusqu'à la fin, allez let's move to the next tutorial (Docker Compose)**