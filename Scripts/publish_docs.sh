#!/usr/bin/env bash

set -euo pipefail

if (( $# < 1 )); then
    echo "Usage: publish_docs.sh <product> [<output-path>]" >&2
    exit 1
fi

DOC_OUTPUT_PATH="${2:-./docs}"
DOC_PRODUCT="$1"

swift package --allow-writing-to-directory "$DOC_OUTPUT_PATH" \
              generate-documentation                          \
              --disable-indexing                              \
              --hosting-base-path "$DOC_PRODUCT"              \
              --output-path "$DOC_OUTPUT_PATH"                \
              --product "$DOC_PRODUCT"                        \
              --transform-for-static-hosting
