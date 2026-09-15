#!/bin/sh
set -e

echo "[entrypoint] starting workbuddy2api..."

if [ -n "${WB2A_AUTH_JSON:-}" ]; then
  AUTH_DIR="${WB2A_AUTH_DIR:-/data/auths}"
  TARGET="$AUTH_DIR/workbuddy-account.json"

  mkdir -p "$AUTH_DIR" 2>/dev/null || echo "[entrypoint] mkdir failed: $AUTH_DIR"

  if printf '%s' "$WB2A_AUTH_JSON" > "$TARGET" 2>/dev/null; then
    chmod 600 "$TARGET" 2>/dev/null || true
    echo "[entrypoint] auth file restored -> $TARGET"
  else
    echo "[entrypoint] ERROR: 无法写入 $TARGET —— 检查 Volume 权限（app uid 10001）"
    exit 1
  fi
else
  echo "[entrypoint] WARN: WB2A_AUTH_JSON 未设置，将无账号可用"
fi

echo "[entrypoint] launching gateway..."
exec /app/wb2api -config /app/config.json
