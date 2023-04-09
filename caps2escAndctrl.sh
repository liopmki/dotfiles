#!/bin/bash

# check if the session type is x11
if [[ "$XDG_SESSION_TYPE" != "x11" ]]; then
  echo "不是x11"
  exit 1
fi

# append XKBOPTIONS to /etc/default/keyboard
echo 'XKBOPTIONS="ctrl:swapcaps"' | sudo tee -a /etc/default/keyboard >/dev/null
# 注意：这个切换ctrl和caps的命令可能不会生效
# 我在popos的gnome和endeavouros的budgie中测试，popos中可以生效
# budgie中不会生效
# 解决方法： budgie中安装gnome-tweak,然后配置ctrl的行为为切换ctrl和caps
# 配置生效

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
touch $AUTOSTART_DIR/xcape.desktop
cat > $AUTOSTART_DIR/xcape.desktop <<EOF
[Desktop Entry]
Name=Xcape
Exec=/usr/bin/xcape -e 'Control_L=Escape'
Terminal=false
Type=Application
StartupNotify=true
EOF

chmod +x ~/.config/autostart/xcape.desktop
echo "配置自动启动完成"
