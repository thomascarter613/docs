#!/usr/bin/env bash

set -e

ADR_DIR="adr"
INDEX_FILE="$ADR_DIR/index.mdx"

mkdir -p "$ADR_DIR"

extract_field() {
  local file="$1"
  local field="$2"
  grep "^$field:" "$file" | head -n1 | sed "s/$field:[[:space:]]*//"
}

echo "Generating ADR index at $INDEX_FILE"

cat <<EOF > "$INDEX_FILE"
---
title: ADR Index
version: 0.1.0
status: active
updated: $(date +"%Y-%m-%d")

owner: thomas
reviewCycle: quarterly

parents: []
children: []
supersedes: []
supersededBy: []

tags:
  - adr
  - index
  - monad
---

# ADR Index

This is the canonical index of all Architecture Decision Records (ADRs) in Monad.

## ADRs
EOF

find "$ADR_DIR" -maxdepth 1 -type f -name "adr-*.mdx" | sort | while read -r FILE; do
  FILENAME=$(basename "$FILE")
  NUMBER=$(echo "$FILENAME" | sed -E 's/^adr-([0-9]+).*/\1/')
  TITLE=$(extract_field "$FILE" "title")
  STATUS=$(extract_field "$FILE" "status")
  VERSION=$(extract_field "$FILE" "version")
  UPDATED=$(extract_field "$FILE" "updated")

  echo "- [ADR-$NUMBER]($FILENAME) — $TITLE (status: \`$STATUS\`, version: \`$VERSION\`, updated: \`$UPDATED\`)" >> "$INDEX_FILE"
done

echo "" >> "$INDEX_FILE"
echo "✔ ADR index generated: $INDEX_FILE"
