#!/bin/bash
set -e

# Set path to your SOPS age key
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"

# Decrypt the staging secret (if needed)
if [[ -f secret.sops.yaml ]]; then
  echo "🔐 Decrypting staging secret.sops.yaml..."
  sops -d secret.sops.yaml > secret.yaml
fi

# Optional: decrypt base secret.enc.yaml if needed
if [[ -f ../../base/secret.enc.yaml ]]; then
  echo "🔐 Decrypting base secret.enc.yaml..."
  sops -d ../../base/secret.enc.yaml > ../../base/secret.yaml
fi

# Build manifests using Kustomize
echo "📦 Building Kubernetes manifests with kustomize..."
kustomize build . > ../../staging.yaml

echo "✅ Done! Output written to manifests/staging.yaml"
