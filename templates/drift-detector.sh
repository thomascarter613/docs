#!/usr/bin/env bash

set -e

ROOT="."
DRIFT=0

echo "🔍 Running Documentation Drift Detection..."

# Utility: extract frontmatter field
extract_field() {
  local file="$1"
  local field="$2"
  grep "^$field:" "$file" | head -n1 | sed "s/$field:[[:space:]]*//"
}

# Utility: emit drift
emit_drift() {
  local type="$1"
  local file="$2"
  local detail="$3"

  echo "🚨 DRIFT [$type] — $file — $detail"
  DRIFT=1
}

# 1. Metadata Drift
echo "→ Checking metadata drift..."

find "$ROOT" -type f -name "*.mdx" | while read -r FILE; do
  for FIELD in title version status updated owner reviewCycle parents children supersedes supersededBy tags; do
    if ! grep -q "^$FIELD:" "$FILE"; then
      emit_drift "MetadataMissing" "$FILE" "Missing field: $FIELD"
    fi
  done
done

# 2. Version Drift
echo "→ Checking version drift..."

find "$ROOT" -type f -name "*.mdx" | while read -r FILE; do
  VERSION=$(extract_field "$FILE" "version")

  if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    emit_drift "VersionInvalid" "$FILE" "Invalid semantic version: $VERSION"
  fi
done

# 3. Lineage Drift
echo "→ Checking lineage drift..."

find "$ROOT" -type f -name "*.mdx" | while read -r FILE; do
  PARENTS=$(extract_field "$FILE" "parents")
  CHILDREN=$(extract_field "$FILE" "children")
  SUPERSEDES=$(extract_field "$FILE" "supersedes")
  SUPERSEDEDBY=$(extract_field "$FILE" "supersededBy")

  # Supersession must be bidirectional
  if [[ "$SUPERSEDES" != "[]" ]]; then
    TARGET=$(echo "$SUPERSEDES" | sed 's/

\[//;s/\]

//;s/"//g')
    if ! grep -q "supersededBy:.*$FILE" "$ROOT/$TARGET.mdx" 2>/dev/null; then
      emit_drift "SupersessionMismatch" "$FILE" "Supersedes $TARGET but target does not reference back"
    fi
  fi
done

# 4. Structural Drift
echo "→ Checking structural drift..."

# Every folder must have an index.mdx
find "$ROOT" -type d ! -path "./.*" | while read -r DIR; do
  if [ ! -f "$DIR/index.mdx" ]; then
    emit_drift "MissingIndex" "$DIR" "Folder missing index.mdx"
  fi
done

# 5. Orphan Drift
echo "→ Checking orphaned documents..."

ALL_DOCS=$(find "$ROOT" -type f -name "*.mdx")
for FILE in $ALL_DOCS; do
  PARENTS=$(extract_field "$FILE" "parents")
  if [[ "$PARENTS" == "[]" ]]; then
    # Allow root-level overview pages
    if [[ ! "$FILE" =~ "overview.mdx" ]]; then
      emit_drift "OrphanDocument" "$FILE" "No parents defined"
    fi
  fi
done

# 6. Review Cycle Drift
echo "→ Checking review cycle drift..."

TODAY=$(date +"%Y-%m-%d")
YEAR=$(date +"%Y")

find "$ROOT" -type f -name "*.mdx" | while read -r FILE; do
  REVIEW=$(extract_field "$FILE" "reviewCycle")
  UPDATED=$(extract_field "$FILE" "updated")

  if [[ "$REVIEW" == "quarterly" ]]; then
    LIMIT=$(date -v -3m -j -f "%Y-%m-%d" "$TODAY" +"%Y-%m-%d" 2>/dev/null || date -d "$TODAY - 3 months" +"%Y-%m-%d")
  elif [[ "$REVIEW" == "semiannual" ]]; then
    LIMIT=$(date -v -6m -j -f "%Y-%m-%d" "$TODAY" +"%Y-%m-%d" 2>/dev/null || date -d "$TODAY - 6 months" +"%Y-%m-%d")
  else
    LIMIT=$(date -v -12m -j -f "%Y-%m-%d" "$TODAY" +"%Y-%m-%d" 2>/dev/null || date -d "$TODAY - 12 months" +"%Y-%m-%d")
  fi

  if [[ "$UPDATED" < "$LIMIT" ]]; then
    emit_drift "ReviewOverdue" "$FILE" "Last updated: $UPDATED (limit: $LIMIT)"
  fi
done

# Final result
if [ "$DRIFT" -eq 1 ]; then
  echo "❌ Documentation drift detected."
  exit 1
else
  echo "✅ No documentation drift detected."
  exit 0
fi
