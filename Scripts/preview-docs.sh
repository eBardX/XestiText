#!/usr/bin/env bash

set -euo pipefail

if (( $# < 1 )); then
    echo "Usage: preview-docs.sh <product> [<port>]" 1>&2
    exit 1
fi

DOC_PRODUCT="$1"
DOC_PRODUCT_LC=$(echo "$DOC_PRODUCT" | tr '[:upper:]' '[:lower:]')

SERVER_PID=""
SERVER_PORT="${2:-8080}"
SERVER_URL="http://localhost:${SERVER_PORT}/documentation/${DOC_PRODUCT_LC}"
SYMBOL_GRAPHS_RAW=""
SYMBOL_GRAPHS=""

cleanup() {
    trap - EXIT INT TERM HUP

    [[ -n "$SERVER_PID" ]]        && kill "$SERVER_PID" 2>/dev/null || true
    [[ -n "$SYMBOL_GRAPHS_RAW" ]] && rm -rf "$SYMBOL_GRAPHS_RAW"
    [[ -n "$SYMBOL_GRAPHS" ]]     && rm -rf "$SYMBOL_GRAPHS"
}

trap cleanup EXIT INT TERM HUP

SYMBOL_GRAPHS_RAW=$(mktemp -d)
SYMBOL_GRAPHS=$(mktemp -d)

swift build --target "$DOC_PRODUCT"         \
            -Xswiftc -emit-symbol-graph     \
            -Xswiftc -emit-symbol-graph-dir \
            -Xswiftc "$SYMBOL_GRAPHS_RAW"

find "$SYMBOL_GRAPHS_RAW" -name "${DOC_PRODUCT}*.symbols.json" \
    -exec cp {} "$SYMBOL_GRAPHS/" \;

xcrun docc preview "Sources/$DOC_PRODUCT/Documentation.docc" \
           --additional-symbol-graph-dir "$SYMBOL_GRAPHS"    \
           --fallback-display-name "$DOC_PRODUCT"            \
           --fallback-bundle-identifier "$DOC_PRODUCT"       \
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
