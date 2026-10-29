#!/usr/bin/env bash
set -euo pipefail

# Install Tailscale and join the tailnet using the auth key and tags passed in
# as instance metadata. --ssh lets the node be reached over Tailscale SSH, and
# the tags make it a tagged device, so it does not belong to a user and its key
# does not expire with that user.
curl -fsSL https://tailscale.com/install.sh | sh

metadata() {
  curl -fsSL -H 'Metadata-Flavor: Google' \
    "http://metadata.google.internal/computeMetadata/v1/instance/attributes/$1"
}

auth_key="$(metadata tailscale-auth-key)"
tags="$(metadata tailscale-tags)"

tailscale up --auth-key="${auth_key}" --advertise-tags="${tags}" --ssh
