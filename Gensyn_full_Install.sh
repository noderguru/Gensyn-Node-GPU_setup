#!/bin/bash

set -e

echo "🔍 Checking and installing required system packages..."

install_if_missing() {
  for pkg in "$@"; do
    if ! dpkg -s "$pkg" >/dev/null 2>&1; then
      echo "📦 Installing: $pkg"
      sudo apt install -y "$pkg"
    else
      echo "✅ $pkg is already installed"
    fi
  done
}

# Update and install base tools
sudo apt update
install_if_missing sudo python3 python3-venv python3-pip curl wget git screen lsof tmux gnupg

# Install Yarn if not present
if ! command -v yarn >/dev/null 2>&1; then
  echo "⬇️ Installing Yarn from official repo..."
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update
  sudo apt install -y yarn
else
  echo "✅ Yarn is already installed"
fi

# Install Node.js 20.x if missing or outdated
if ! command -v node >/dev/null 2>&1 || [[ "$(node -v)" < "v20" ]]; then
  echo "⬇️ Installing Node.js v20..."
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt install -y nodejs
else
  echo "✅ Node.js already installed: $(node -v)"
fi

# Clone or replace rl-swarm project
cd $HOME
if [ -d rl-swarm ]; then
  echo "🧹 Removing existing rl-swarm directory..."
  rm -rf rl-swarm
fi

echo "📥 Cloning rl-swarm..."
git clone https://github.com/zunxbt/rl-swarm.git
cd rl-swarm

# Overwrite modal-login/package.json
mkdir -p modal-login
cd modal-login

echo "📝 Writing new package.json with locked viem@2.22.6..."
cat > package.json <<EOF
{
  "name": "ui-components-qs-nextjs",
  "version": "0.1.0",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "@account-kit/core": "4.20.0",
    "@account-kit/infra": "4.20.0",
    "@account-kit/react": "4.20.0",
    "@account-kit/smart-contracts": "4.20.0",
    "@tanstack/react-query": "5.71.1",
    "@turnkey/api-key-stamper": "0.4.4",
    "@turnkey/http": "2.22.0",
    "next": "14.2.4",
    "react": "18.3.1",
    "react-dom": "18.3.1",
    "viem": "2.22.6",
    "wagmi": "2.12.7"
  },
  "resolutions": {
    "viem": "2.22.6"
  },
  "devDependencies": {
    "@types/node": "20.17.30",
    "@types/react": "18.3.20",
    "@types/react-dom": "18.3.5",
    "eslint": "8.57.1",
    "eslint-config-next": "14.2.4",
    "postcss": "8.5.3",
    "tailwindcss": "3.4.17",
    "typescript": "5.8.2"
  }
}
EOF

rm -rf node_modules yarn.lock
yarn install --force

# Return to rl-swarm root
cd ../

# Create Python virtual environment
echo "🐍 Creating Python virtual environment..."
python3 -m venv .venv

# Start run_rl_swarm.sh in tmux
SESSION_NAME="rl-swarm-session"
echo "🖥 Starting run_rl_swarm.sh inside tmux session: $SESSION_NAME"
tmux new-session -s "$SESSION_NAME" "bash -c '. .venv/bin/activate && ./run_rl_swarm.sh'"
