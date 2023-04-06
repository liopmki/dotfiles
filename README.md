# dotfiles

## budgie

**stow**:

一级子目录表示软件名  
将该软件的配置移动到该目录下  
`stow <name>`  

## 映射caps到esc和ctrl

### Linux

**核心思想：**
1. 将caps映射成ctrl（caps与ctrl交换等等）
2. 使用xcape实现单次点击ctrl为esc`/usr/bin/xcape -e 'Control_L=Escape'`(-t 参数表示视为单次点击的时间)

[基本实现-bash script](./caps2escAndctrl.sh)

> 详细信息 [archwiki-keyboard_configuration](https://wiki.archlinux.org/title/Xorg/Keyboard_configuration#One-click_key_functions)
  
1. 检查是否是`X`协议

```shell
echo $XDG_SESSION_TYPE
```
2. 将`XKBOPTIONS="ctrl:swapcaps"` 添加到`/etc/default/keyboard`

**TODO:**
- [ ] 在不可变系统(Fedora Silverblue、OpenSuse Micro OS)和NixOS中实现

> 这个切换ctrl和caps的命令可能不会生效
> 我在popos的gnome和endeavouros的budgie中测试，popos中可以生效
> budgie中不会生效
> 解决方法： budgie中安装gnome-tweak,然后配置ctrl的行为为切换ctrl和caps
> 配置生效

```shell
echo "XKBOPTIONS="ctrl:swapcaps"" >> /etc/default/keyboard
```
1. 安装`xcape`

```shell
# arch
sudo pcman -S xcape

# ubuntu
sudo apt install xcape
```
4. 配置自启动
    1. `sudo vim ~/.config/autostart/xcape.desktop`
      ```desktop
      [Desktop Entry]
      Name=Xcape
      Exec=/usr/bin/xcape -e 'Control_L=Escape'
      Terminal=false
      Type=Application
      StartupNotify=true
      ```
    2. `sudo chmod +x ~/.config/autostart/xcape.desktop`
### Windows

#### Autohotkey

> autohotkey 可以v1和v2都安装，先安装v2再安装v1,v1会被视为扩展安装

此脚本适用于autohotkey v1

```
g_LastCtrlKeyDownTime := 0
g_AbortSendEsc := false
g_ControlRepeatDetected := false

*CapsLock::
    if (g_ControlRepeatDetected)
    {
        return
    }

    send,{Ctrl down}
    g_LastCtrlKeyDownTime := A_TickCount
    g_AbortSendEsc := false
    g_ControlRepeatDetected := true

    return

*CapsLock Up::
    send,{Ctrl up}
    g_ControlRepeatDetected := false
    if (g_AbortSendEsc)
    {
        return
    }
    current_time := A_TickCount
    time_elapsed := current_time - g_LastCtrlKeyDownTime
    if (time_elapsed <= 250)
    {
        SendInput {Esc}
    }
    return

~*^a::
~*^b::
~*^c::
~*^d::
~*^e::
~*^f::
~*^g::
~*^h::
~*^i::
~*^j::
~*^k::
~*^l::
~*^m::
~*^n::
~*^o::
~*^p::
~*^q::
~*^r::
~*^s::
~*^t::
~*^u::
~*^v::
~*^w::
~*^x::
~*^y::
~*^z::
~*^1::
~*^2::
~*^3::
~*^4::
~*^5::
~*^6::
~*^7::
~*^8::
~*^9::
~*^0::
~*^Space::
~*^Backspace::
~*^Delete::
~*^Insert::
~*^Home::
~*^End::
~*^PgUp::
~*^PgDn::
~*^Tab::
~*^Return::
~*^,::
~*^.::
~*^/::
~*^;::
~*^'::
~*^[::
~*^]::
~*^\::
~*^-::
~*^=::
~*^`::
~*^F1::
~*^F2::
~*^F3::
~*^F4::
~*^F5::
~*^F6::
~*^F7::
~*^F8::
~*^F9::
~*^F10::
~*^F11::
~*^F12::
    g_AbortSendEsc := true
    return
```

#### 自动启动

1. 将脚本转为`.exe`文件
2. 创建快捷方式，并将快捷方式移动到`C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup`