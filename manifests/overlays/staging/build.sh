#!/bin/bash
set -e

# Set the path to your SOPS age key (in GitHub Actions, this is configured)
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"

# Decrypt the staging secret (if exists)
if [[ -f secret.sops.yaml ]]; then
  echo "🔐 Decrypting secret.sops.yaml..."
  sops -d secret.sops.yaml > secret.yaml
fi

# Optional: decrypt base secret if needed
if [[ -f ../../base/secret.enc.yaml ]]; then
  echo "🔐 Decrypting base secret.enc.yaml..."
  sops -d ../../base/secret.enc.yaml > ../../base/secret.yaml
fi

# Run kustomize from the correct directory (we're already in staging/)
echo "📦 Building manifests from overlays/staging"
kustomize build . > ../../../staging.yaml

echo "✅ Manifest written to manifests/staging.yaml"
