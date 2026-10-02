#!/usr/bin/env bash
set -euo pipefail

# Install Tailscale and join the tailnet using the auth key passed in as
# instance metadata. --ssh lets the node be reached over Tailscale SSH.
curl -fsSL https://tailscale.com/install.sh | sh

auth_key="$(curl -fsSL -H 'Metadata-Flavor: Google' \
  http://metadata.google.internal/computeMetadata/v1/instance/attributes/tailscale-auth-key)"

tailscale up --auth-key="${auth_key}" --ssh
