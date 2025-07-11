#!/usr/bin/env bash
set -e

BASE="containerization"

# List every file you want to scaffold (relative to repo root)
files=(
  "$BASE/README.md"
  "$BASE/getting-started.md"
  "$BASE/best-practices.md"
  "$BASE/cheatsheet.md"

  "$BASE/basics/hello-world/Dockerfile"
  "$BASE/basics/hello-world/run.sh"
  "$BASE/basics/environment-variables.md"

  "$BASE/images/simple-node/Dockerfile"
  "$BASE/images/simple-node/app.js"
  "$BASE/images/multi-stage-builds/Dockerfile"
  "$BASE/images/multi-stage-builds/build-and-push.md"

  "$BASE/docker-compose/docker-compose.yml"
  "$BASE/docker-compose/compose-tips.md"
  "$BASE/docker-compose/multi-service-app/docker-compose.yml"
  "$BASE/docker-compose/multi-service-app/README.md"

  "$BASE/networking/bridge-vs-host.md"
  "$BASE/networking/service-discovery.md"
  "$BASE/networking/custom-networks/setup.sh"
  "$BASE/networking/custom-networks/README.md"

  "$BASE/storage/volumes-vs-bind-mounts.md"
  "$BASE/storage/backup-restore.md"
  "$BASE/storage/persistent-volumes/create.sh"
  "$BASE/storage/persistent-volumes/README.md"

  "$BASE/security/image-scanning.md"
  "$BASE/security/user-namespaces.md"
  "$BASE/security/secrets-management/README.md"
  "$BASE/security/secrets-management/demo.yaml"

  "$BASE/registry/run-local-registry.sh"
  "$BASE/registry/push-pull.md"
  "$BASE/registry/auth-and-tls.md"
)

for filepath in "${files[@]}"; do
  mkdir -p "$(dirname "$filepath")"
  touch "$filepath"
done

echo "✅ All directories and placeholder files have been created under '$BASE/'"
