#!/bin/sh
set -e

if [ -n "${WB2A_AUTH_JSON:-}" ]; then
  AUTH_DIR="${WB2A_AUTH_DIR:-/data/auths}"
  mkdir -p "$AUTH_DIR"
  printf '%s' "$WB2A_AUTH_JSON" > "$AUTH_DIR/workbuddy-account.json"
  chmod 600 "$AUTH_DIR/workbuddy-account.json"
  echo "[entrypoint] auth file restored -> $AUTH_DIR/workbuddy-account.json"
else
  echo "[entrypoint] WARN: WB2A_AUTH_JSON not set, no account credential"
fi

exec /app/wb2api -config /app/config.json
