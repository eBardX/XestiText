#!/usr/bin/env bash

set -euo pipefail

if (( $# < 1 )); then
    echo "Usage: preview_docs.sh <product> [<port>]" 1>&2
    exit 1
fi

DOC_PRODUCT="$1"
DOC_PRODUCT_LC=$(echo "$DOC_PRODUCT" | tr '[:upper:]' '[:lower:]')

SERVER_PID=""
SERVER_PORT="${2:-8080}"
SERVER_URL="http://localhost:${SERVER_PORT}/documentation/${DOC_PRODUCT_LC}"

cleanup() {
    trap - EXIT INT TERM HUP
    
    [[ -n "$SERVER_PID" ]] && kill "$SERVER_PID" 2>/dev/null || true
}

trap cleanup EXIT INT TERM HUP

swift package --disable-sandbox        \
              preview-documentation    \
              --product "$DOC_PRODUCT" \
              --port "$SERVER_PORT" &

SERVER_PID=$!

echo "Waiting for preview server..." 1>&2

while true; do
    if ! kill -0 "$SERVER_PID" 2>/dev/null; then
        echo 'Preview server exited unexpectedly!' 1>&2
        exit 1
    fi

    if curl -s "http://localhost:${SERVER_PORT}" > /dev/null 2>&1; then
        break
    fi

    sleep 1
done

open "$SERVER_URL"

wait "$SERVER_PID" || true
