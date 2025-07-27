#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Print each command to the console before it is executed for debugging.
set -x

echo "Spot-Sync Initializing..."

# Check for required environment variables
if [ -z "$SPOTIFY_CLIENT_ID" ] || [ -z "$SPOTIFY_CLIENT_SECRET" ] || [ -z "$PLAYLIST_URL" ]; then
  echo "Error: SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET, and PLAYLIST_URL environment variables must be set."
  exit 1
fi

# Set default values if not provided
SYNC_DIRECTORY=${SYNC_DIRECTORY:-/music}
SYNC_INTERVAL_SECONDS=${SYNC_INTERVAL_SECONDS:-3600}

# Ensure the target directory exists before trying to cd into it
mkdir -p "$SYNC_DIRECTORY"
cd "$SYNC_DIRECTORY"

echo "Configuration:"
echo "-> Syncing inside directory: $(pwd)"
echo "-> Sync Interval: $SYNC_INTERVAL_SECONDS seconds"
echo "----------------------------------------"

# Loop indefinitely to run sync periodically
while true; do
  echo "[$(date)] Starting sync for playlist: $PLAYLIST_URL"

  # Run the spotdl command. Since we are already in the target directory,
  # we can just use "." to specify the current directory.
  spotdl sync "$PLAYLIST_URL" --save-file sync.spotdl --client-id "$SPOTIFY_CLIENT_ID" --client-secret "$SPOTIFY_CLIENT_SECRET"

  echo "[$(date)] Sync complete. Sleeping for $SYNC_INTERVAL_SECONDS seconds..."
  sleep "$SYNC_INTERVAL_SECONDS"
done
