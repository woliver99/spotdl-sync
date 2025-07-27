#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Spot-Sync Initializing..."

# Check for required environment variables
if [ -z "$SPOTIFY_CLIENT_ID" ] || [ -z "$SPOTIFY_CLIENT_SECRET" ] || [ -z "$PLAYLIST_URL" ]; then
  echo "Error: SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET, and PLAYLIST_URL environment variables must be set."
  exit 1
fi

# Set default values if not provided
SYNC_DIRECTORY=${SYNC_DIRECTORY:-/music}
SYNC_INTERVAL_SECONDS=${SYNC_INTERVAL_SECONDS:-3600} # Default to 1 hour (3600 seconds)

echo "Configuration:"
echo "-> Sync Directory: $SYNC_DIRECTORY"
echo "-> Sync Interval: $SYNC_INTERVAL_SECONDS seconds"
echo "----------------------------------------"

# Loop indefinitely to run sync periodically
while true; do
  echo "[$(date)] Starting sync for playlist: $PLAYLIST_URL"

  # Run the spotdl command with all required arguments
  spotdl --client-id "$SPOTIFY_CLIENT_ID" \
         --client-secret "$SPOTIFY_CLIENT_SECRET" \
         sync "$PLAYLIST_URL" "$SYNC_DIRECTORY"

  echo "[$(date)] Sync complete. Sleeping for $SYNC_INTERVAL_SECONDS seconds..."
  sleep "$SYNC_INTERVAL_SECONDS"
done
