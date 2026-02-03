#!/bin/bash

# PersonaPlex Server Launcher
# Make sure you've set HF_TOKEN before running this script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "$HF_TOKEN" ]; then
    echo "Error: HF_TOKEN environment variable is not set."
    echo "Please run: export HF_TOKEN=your_huggingface_token"
    echo "Get your token from: https://huggingface.co/settings/tokens"
    echo "Also make sure you've accepted the license at: https://huggingface.co/nvidia/personaplex-7b-v1"
    exit 1
fi

# Create temporary SSL directory for HTTPS
SSL_DIR=$(mktemp -d)

echo "Starting PersonaPlex server..."
echo "Once started, access the Web UI at the URL printed below."
echo ""

# Add moshi to Python path and run server
export PYTHONPATH="$SCRIPT_DIR/moshi:$PYTHONPATH"
python3 -m moshi.server --ssl "$SSL_DIR"
