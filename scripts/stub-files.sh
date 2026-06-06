#!/usr/bin/env bash

set -e

TODAY=$(date +"%Y-%m-%d")

create() {
  FILE="$1"
  TITLE=$(basename "$FILE" .mdx | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')

  mkdir -p "$(dirname "$FILE")"

  if [ ! -f "$FILE" ]; then
    cat <<EOF > "$FILE"
---
title: $TITLE
version: 0.1.0
status: draft
updated: $TODAY

owner: thomas
reviewCycle: quarterly

parents: []
children: []
supersedes: []
supersededBy: []

tags:
  - documentation
  - monad
  - lineage
---

# $TITLE

Content coming soon.
EOF

    echo "Created: $FILE"
  else
    echo "Exists:  $FILE"
  fi
}

# Founder Log
create founder-log/overview.mdx
create founder-log/daily/2026-06-05.mdx
create founder-log/daily/template.mdx
create founder-log/weekly/overview.mdx
create founder-log/monthly/overview.mdx

# Narrative Engine
create narrative/overview.mdx
create narrative/founder-narrative.mdx
create narrative/publishing/system.mdx
create narrative/publishing/cadence.mdx
create narrative/publishing/templates.mdx
create narrative/positioning/system.mdx
create narrative/positioning/framework.mdx
create narrative/authority/system.mdx
create narrative/authority/assets.mdx

# Pipeline Engine
create pipeline/overview.mdx
create pipeline/discovery/system.mdx
create pipeline/discovery/questions.mdx
create pipeline/discovery/scripts.mdx
create pipeline/sales/system.mdx
create pipeline/sales/script.mdx
create pipeline/sales/pricing.mdx
create pipeline/pricing/models.mdx
create pipeline/pricing/framework.mdx
create pipeline/review/system.mdx
create pipeline/review/metrics.mdx

# Delivery Engine
create delivery/overview.mdx
create delivery/client/system.mdx
create delivery/client/workflows.mdx
create delivery/extraction/system.mdx
create delivery/extraction/templates.mdx
create delivery/engagement/templates.mdx
create delivery/engagement/scopes.mdx

# Platform Engine
create platform/overview.mdx
create platform/lineage/overview.mdx
create platform/lineage/map.mdx
create platform/architecture/decisions.mdx
create platform/architecture/adr-template.mdx
create platform/templates/overview.mdx
create platform/templates/modules.mdx

# Governance
create governance/overview.mdx
create governance/decision-filters/overview.mdx
create governance/decision-filters/examples.mdx
create governance/docs/standards.mdx
create governance/docs/templates.mdx
create governance/rhythm/weekly.mdx
create governance/rhythm/daily.mdx

# Knowledge Graph
create knowledge/overview.mdx
create knowledge/concepts/core.mdx
create knowledge/concepts/derived.mdx
create knowledge/patterns/overview.mdx
create knowledge/patterns/library.mdx
create knowledge/lineage/overview.mdx
create knowledge/lineage/map.mdx

echo "✔ All versioned, lineage-aware file stubs created."
