#!/bin/bash

echo "🔧 正在安装 VS Code 打开脚本到文件管理器..."

# 确保 code 命令已可用
if ! command -v code &> /dev/null; then
    echo "❌ 未检测到 'code' 命令，请先打开 VS Code -> Ctrl+Shift+P -> 安装 Shell Command"
    exit 1
fi

# 安装 nautilus 扩展依赖（可选）
sudo apt update
sudo apt install -y nautilus nautilus-extension-gnome-terminal

# 创建 nautilus 脚本目录（如不存在）
mkdir -p ~/.local/share/nautilus/scripts

# 创建脚本文件
cat << 'EOF' > ~/.local/share/nautilus/scripts/Open_in_VSCode
#!/bin/bash
code "$(echo "$NAUTILUS_SCRIPT_CURRENT_URI" | sed 's|^file://||')"
EOF

# 赋予执行权限
chmod +x ~/.local/share/nautilus/scripts/Open_in_VSCode

# 重启 nautilus
nautilus -q

echo "✅ 安装完成！请在文件管理器中右键 -> Scripts -> Open_in_VSCode 来打开当前目录。"
