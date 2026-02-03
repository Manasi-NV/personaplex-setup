# Quick Setup Guide for PersonaPlex

This is a fork with quick-start scripts for running PersonaPlex on an H100 or similar GPU.

## Prerequisites

- NVIDIA GPU (H100, A100, or similar with 40GB+ VRAM)
- Ubuntu 22.04 or similar
- HuggingFace account with access to the model

## One-Time Setup

### 1. Accept the Model License

Go to https://huggingface.co/nvidia/personaplex-7b-v1 and click "Agree and access repository"

### 2. Get Your HuggingFace Token

Get your token from https://huggingface.co/settings/tokens

### 3. Install Dependencies

```bash
# Clone this repo
git clone https://github.com/Manasi-NV/personaplex-setup.git
cd personaplex-setup

# Install system dependencies
sudo apt update && sudo apt install -y libopus-dev

# Install Python dependencies
pip install "numpy>=1.26,<2.2" "torch>=2.2.0,<2.5" "safetensors>=0.4.0,<0.5" \
    "huggingface-hub>=0.24,<0.25" "einops==0.7" "sentencepiece==0.2" \
    "sounddevice==0.5" "sphn>=0.1.4,<0.2" "aiohttp>=3.10.5,<3.11"
```

## Running the Server

```bash
# Set your HuggingFace token
export HF_TOKEN=your_token_here

# Start the server
./start_server.sh
```

The server will start on `https://0.0.0.0:8998`

## Accessing the Web UI

### Local Access
Open `https://localhost:8998` in your browser

### Remote/Team Access
1. Open the firewall port: `sudo ufw allow 8998/tcp`
2. Share the URL: `https://<your-server-ip>:8998`

**Note:** Accept the self-signed certificate warning in your browser (click "Advanced" → "Proceed")

## Troubleshooting

### "No module named moshi.server"
The start script sets PYTHONPATH automatically. If running manually:
```bash
PYTHONPATH="$(pwd)/moshi:$PYTHONPATH" python3 -m moshi.server --ssl "$(mktemp -d)"
```

### GPU Memory Issues
For GPUs with less VRAM, use CPU offload:
```bash
PYTHONPATH="$(pwd)/moshi:$PYTHONPATH" python3 -m moshi.server --ssl "$(mktemp -d)" --cpu-offload
```
