#!/bin/bash

# check if the session type is x11
if [[ "$XDG_SESSION_TYPE" != "x11" ]]; then
  echo "不是x11"
  exit 1
fi

# append XKBOPTIONS to /etc/default/keyboard
echo 'XKBOPTIONS="ctrl:swapcaps"' | sudo tee -a /etc/default/keyboard >/dev/null

# check and install xcape
if ! command -v xcape >/dev/null 2>&1; then
  echo "开始安装xcape"
  if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y xcape
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --noconfirm xcape
  else
    echo "未知的包管理器"
    exit 1
  fi
else
  echo "xcape已经安装"
fi

# configure autostart
AUTOSTART_DIR="$HOME/.config/autostart"
if [ ! -d "$AUTOSTART_DIR" ]; then
  mkdir -p "$AUTOSTART_DIR"
fi
sudo touch $AUTOSTART_DIR/xcape.desktop
sudo cat > $AUTOSTART_DIR/xcape.desktop <<EOF
[Desktop Entry]
Name=Xcape
Exec=/usr/bin/xcape -e 'Control_L=Escape'
Terminal=false
Type=Application
StartupNotify=true
EOF

sudo chmod +x ~/.config/autostart/xcape.desktop
echo "配置自动启动完成"