# Docker Images: Building, Optimizing & Pushing
In the **Images** module, we'll dive deep into crafting real-world Docker images. By the end, you'll be able to:
- Build and run a simple Node.js app image
- Inspect Image layers and understand caching
- Create multi-stage builds to keep images small
- Tag, push, and pull images to/from a registry

---
## Prerequisites
- You've completed the [basics tutorial](../basics/README.md) and can build/run a simple image.
- Node.js (v14+) installed locally (for building the sample app)
- A Docker Hub account (or other registry) for pushing images.

**How to install Node.js**
On macOS, you can easily install Node.js using Homebrew
- First, install homebrew if you don't have it already using the command:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
- Use homebrew to install Node.js (npm is included automatically):
```bash
brew install node
```
- Verify installation:
```bash
node -v          # should output something like v24.x.x
npm -v           # should output npm version (e.g. 11.x.x)
```

Next: go to [simple Node.js App image](simple-node/README.md)