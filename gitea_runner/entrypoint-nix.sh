#!/usr/bin/env bash
set -euo pipefail

if [ ! -x /nix/var/nix/profiles/default/bin/nix ] || ! /nix/var/nix/profiles/default/bin/nix --version >/dev/null 2>&1; then
  echo "[entrypoint-nix] /nix/var/nix/profiles/default/bin/nix missing or broken; seeding /nix from /opt/nix-seed.tar.gz..." >&2
  tar -xzf /opt/nix-seed.tar.gz -C /nix
fi

exec /usr/local/bin/run.sh "$@"
