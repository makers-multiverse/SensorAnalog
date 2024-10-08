#!/bin/bash

# Directory for consumers
CONSUMERS_DIR="$HOME/ci-consumers"
UNIVERSAL_MAKER_BOX_REPO="https://github.com/makers-multiverse/UniversalMakerBox.git"

# Clean up any existing consumer directory
if [ -d "$CONSUMERS_DIR" ]; then
  rm -rf "$CONSUMERS_DIR"
fi

# Create a fresh consumers directory
mkdir -p "$CONSUMERS_DIR"

# Clone UniversalMakerBox
echo "Cloning UniversalMakerBox into $CONSUMERS_DIR..."
git clone "$UNIVERSAL_MAKER_BOX_REPO" "$CONSUMERS_DIR/UniversalMakerBox"

# Navigate to the UniversalMakerBox directory
cd "$CONSUMERS_DIR/UniversalMakerBox" || exit

# Run the build and tests for UniversalMakerBox
echo "Building and running tests for UniversalMakerBox..."
bash prepare.sh
bash build.sh    # Or the appropriate build command for the consumer

# Capture exit code to detect failure
if [ $? -ne 0 ]; then
  echo "Error: UniversalMakerBox build/tests failed."
  exit 1
fi

echo "Consumers prepared and tested successfully."
