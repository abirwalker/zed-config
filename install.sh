#!/usr/bin/env bash
set -e

echo "============================================"
echo "   Installing Zed Custom Config on Linux    "
echo "============================================"

# 1. Detect Zed config directory
if [ "$(uname)" = "Darwin" ]; then
    ZED_CONFIG_DIR="$HOME/Library/Application Support/Zed"
else
    ZED_CONFIG_DIR="$HOME/.config/zed"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$ZED_CONFIG_DIR"
mkdir -p "$ZED_CONFIG_DIR/snippets"

# 2. Backup existing configurations
if [ -d "$ZED_CONFIG_DIR" ] && [ "$(ls -A "$ZED_CONFIG_DIR" 2>/dev/null)" ]; then
    BACKUP_DIR="$HOME/.config/zed_backup_$(date +%Y%m%d_%H%M%S)"
    echo "[i] Backing up existing config to: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    cp -r "$ZED_CONFIG_DIR"/* "$BACKUP_DIR/" 2>/dev/null || true
fi

# 3. Copy Linux-optimized configurations
if [ -d "$SCRIPT_DIR/linux" ]; then
    cp "$SCRIPT_DIR/linux/settings.json" "$ZED_CONFIG_DIR/settings.json"
    cp "$SCRIPT_DIR/linux/tasks.json" "$ZED_CONFIG_DIR/tasks.json"
    echo "[+] Installed Linux-optimized settings.json & tasks.json"
else
    cp "$SCRIPT_DIR/settings.json" "$ZED_CONFIG_DIR/settings.json"
    cp "$SCRIPT_DIR/tasks.json" "$ZED_CONFIG_DIR/tasks.json"
fi

# 4. Copy universal keymaps, debug configs & snippets
cp "$SCRIPT_DIR/keymap.json" "$ZED_CONFIG_DIR/keymap.json"
cp "$SCRIPT_DIR/debug.json" "$ZED_CONFIG_DIR/debug.json"
cp -r "$SCRIPT_DIR/snippets/"* "$ZED_CONFIG_DIR/snippets/"

echo "[+] Installed keymap.json (Vim shortcuts: space b, space j, space c, space p)"
echo "[+] Installed debug.json (DAP debugger)"
echo "[+] Installed snippets (Java & C++)"

# 5. Check Ubuntu/Linux toolchain
echo ""
echo "[*] Checking development tools:"

if command -v g++ >/dev/null 2>&1; then
    echo "  [OK] g++ found: $(g++ --version | head -n1)"
else
    echo "  [!] g++ missing. Install with: sudo apt install build-essential"
fi

if command -v java >/dev/null 2>&1; then
    echo "  [OK] java found: $(java -version 2>&1 | head -n1)"
else
    echo "  [!] java missing. Install with: sudo apt install openjdk-21-jdk"
fi

if command -v python3 >/dev/null 2>&1; then
    echo "  [OK] python3 found: $(python3 --version)"
else
    echo "  [!] python3 missing. Install with: sudo apt install python3"
fi

echo ""
echo "============================================"
echo "   Installation Complete! Restart Zed.      "
echo "============================================"
