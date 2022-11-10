#!/bin/bash

echo "Generate Credentials Code"
CREDENTIALS_DIR="$SRCROOT/credentials"

# Set credentials if local script for adding environment variables exist
if [ -f "$CREDENTIALS_DIR/add_credentials_to_env.sh" ]; then
  echo "Add credentials to environement"
  source "$CREDENTIALS_DIR/add_credentials_to_env.sh"
fi

$SRCROOT/Pods/Sourcery/bin/sourcery --templates "$CREDENTIALS_DIR/Credentials.stencil" --sources . --output "$SRCROOT/Runner" --args apiKey=$API_KEY --args clientID=$CLIENT_ID