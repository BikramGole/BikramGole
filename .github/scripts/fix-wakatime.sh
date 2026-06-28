#!/bin/bash
# Post-process the metrics SVG to use WakaTime badge total instead of API data

SVG_FILE="github-metrics.svg"
BADGE_URL="https://wakatime.com/badge/user/07f2f83c-a4f8-407e-ac67-6aafb674ebf8.svg"

# Fetch the badge SVG and extract the total hours text
BADGE_TEXT=$(curl -s "$BADGE_URL" | grep -oP '[0-9]+ hrs [0-9]+ mins' | head -1)

if [ -z "$BADGE_TEXT" ]; then
  echo "Failed to fetch badge data"
  exit 1
fi

echo "Badge total: $BADGE_TEXT"

# Extract hours
HOURS=$(echo "$BADGE_TEXT" | grep -oP '^[0-9]+')
echo "Hours: $HOURS"

# Update the "coding hours recorded" line in the SVG
sed -i "s/~[0-9]\+ coding hours recorded/~$HOURS coding hours recorded/" "$SVG_FILE"

echo "Updated $SVG_FILE with $HOURS coding hours"
