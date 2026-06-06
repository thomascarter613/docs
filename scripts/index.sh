#!/usr/bin/env bash

set -e

TODAY=$(date +"%Y-%m-%d")

generate_index() {
  DIR="$1"
  INDEX_FILE="$DIR/index.mdx"

  TITLE=$(basename "$DIR" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')

  echo "Generating index for: $DIR"

  # Collect child pages
  CHILDREN=$(find "$DIR" -maxdepth 1 -type f -name "*.mdx" ! -name "index.mdx" | sort)

  # Collect subfolders
  SUBFOLDERS=$(find "$DIR" -maxdepth 1 -mindepth 1 -type d | sort)

  mkdir -p "$DIR"

  cat <<EOF > "$INDEX_FILE"
---
title: $TITLE Index
version: 0.1.0
status: active
updated: $TODAY

owner: thomas
reviewCycle: quarterly

parents: []
children: []
supersedes: []
supersededBy: []

tags:
  - index
  - documentation
  - monad
---

# $TITLE

This is the index page for the **$TITLE** section.

## Pages

EOF

  for FILE in $CHILDREN; do
    NAME=$(basename "$FILE" .mdx)
    DISPLAY=$(echo "$NAME" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
    echo "- [$DISPLAY]($(basename "$FILE"))" >> "$INDEX_FILE"
  done

  echo "" >> "$INDEX_FILE"
  echo "## Subsections" >> "$INDEX_FILE"
  echo "" >> "$INDEX_FILE"

  for SUB in $SUBFOLDERS; do
    NAME=$(basename "$SUB")
    DISPLAY=$(echo "$NAME" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
    echo "- [$DISPLAY]($NAME/index)" >> "$INDEX_FILE"
  done

  echo "✔ Created index: $INDEX_FILE"
}

# Generate index pages for all directories
find . -type d ! -path "./.*" | while read -r DIR; do
  generate_index "$DIR"
done

echo "✔ All index pages generated."
