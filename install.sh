#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Run this installer as root (sudo ./install.sh)."
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive

echo "[1/6] Installing OS dependencies..."
apt-get update -y
apt-get install -y \
  curl \
  git \
  screenfetch \
  wondershaper \
  lxd \
  python3 \
  python3-pip \
  python3-venv

echo "[2/6] Initializing LXD..."
if ! lxd --version >/dev/null 2>&1; then
  echo "LXD installation failed or binary not available."
  exit 1
fi

# Initialize once; skip if already initialized.
if ! lxc profile list >/dev/null 2>&1; then
  lxd init --auto
fi

echo "[3/6] Preparing Python virtual environment..."
cd "$(dirname "$0")"
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip

echo "[4/6] Installing bot Python dependencies..."
pip install discord.py psutil

echo "[5/6] Checking LXC command availability..."
lxc version >/dev/null

echo "[6/6] Done."
echo "Activate env with: source .venv/bin/activate"
echo "Start bot with: python3 main.py"
