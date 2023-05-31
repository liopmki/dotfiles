local wezterm = require("wezterm")

-- 不同系统的不同配置
-- variables
local default_prog
local hide_tab_bar_if_only_one_tab
local tab_bar_at_bottom
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    default_prog = { 'nu' }
    hide_tab_bar_if_only_one_tab = false
    tab_bar_at_bottom = false
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
    default_prog = { 'zsh' }
    hide_tab_bar_if_only_one_tab = true
    tab_bar_at_bottom = true
else
    default_prog = { 'zsh' }
    hide_tab_bar_if_only_one_tab = true
    tab_bar_at_bottom = true
end

return {
    -- OpenGL for GPU acceleration, Software for CPU
    front_end = "OpenGL",

    -- [[ Appearance ]]
    -- [ color_scheme ]
    color_scheme = "Catppuccin Mocha",

    -- [ Tab Bar ]
    enable_tab_bar = true,                                       -- 开启 tab bar
    -- show_tab_index_in_tab_bar = true,
    hide_tab_bar_if_only_one_tab = hide_tab_bar_if_only_one_tab, -- 如果只有一个tab则隐藏tab bar
    tab_bar_at_bottom = tab_bar_at_bottom,                       -- tab bar  的位置：底端
    -- End
    use_fancy_tab_bar = false,                                   -- false: tab使用color_scheme的主题；true :tab 使用系统的主题
    tab_max_width = 16,                                          -- default is 16

    -- [ Padding ]
    window_padding = {
        left = 25,
        right = 25,
        top = 25,
        bottom = 25
    },

    -- [ Opacity 透明度]
    window_background_opacity = 0.95,

    -- [ Title bar ]
    -- TIPS: NONE | TITLE | RESIZE
    window_decorations = "TITLE",

    -- [ Cursor style ]
    default_cursor_style = "BlinkingUnderline",

    -- [[ Default Shell ]]
    default_prog = default_prog,

    -- [[ Launcher Menu ]]
    -- TIPS:
    --      左键 + 号可以新建tab，右键 + 号可以进入 Launcher Menu
    launch_menu = {
        { label = 'Nu Shell',    args = { 'nu' } },
        { label = 'Power Shell', args = { 'pwsh' } },
        { label = 'Cmd',         args = { 'cmd' } },
    },

    -- [[ Font Config ]]
    font = wezterm.font_with_fallback {
        -- 会在这个table中查找font，
        'Maple Mono SC NF',
    },
    bold_brightens_ansi_colors = true,
    warn_about_missing_glyphs = false,
    font_size = 14,
    line_height = 1.0,

    -- [[ Keybinds ]]
    -- TIPS:
    --      Possible Modifier
    --      SUPER,WIN
    --      CTRL
    --      SHIFT
    --      ALT
    --      LEADER
    --      VoidSymbol
    disable_default_key_bindings = true,
    keys = {
        {
            key = [[\]],
            mods = "CTRL|ALT",
            action = wezterm.action({
                SplitHorizontal = {
                    domain = "CurrentPaneDomain"
                }
            })
        },
        {
            key = [[\]],
            mods = "CTRL",
            action = wezterm.action({
                SplitVertical = {
                    domain = "CurrentPaneDomain"
                }
            })
        },
        {
            key = "q",
            mods = "CTRL",
            action = wezterm.action({
                CloseCurrentPane = {
                    confirm = false
                }
            })
        },
        {
            key = "h",
            mods = "CTRL|SHIFT",
            action = wezterm.action({
                ActivatePaneDirection = "Left"
            })
        },
        {
            key = "l",
            mods = "CTRL|SHIFT",
            action = wezterm.action({
                ActivatePaneDirection = "Right"
            })
        },
        {
            key = "k",
            mods = "CTRL|SHIFT",
            action = wezterm.action({
                ActivatePaneDirection = "Up"
            })
        },
        {
            key = "j",
            mods = "CTRL|SHIFT",
            action = wezterm.action({
                ActivatePaneDirection = "Down"
            })
        },
        {
            key = "h",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({
                AdjustPaneSize = { "Left", 1 }
            })
        },
        {
            key = "l",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({
                AdjustPaneSize = { "Right", 1 }
            })
        },
        {
            key = "k",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({
                AdjustPaneSize = { "Up", 1 }
            })
        },
        {
            key = "j",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({
                AdjustPaneSize = { "Down", 1 }
            })
        },
        -- browser-like bindings for tabbing
        {
            key = "t",
            mods = "CTRL",
            action = wezterm.action({
                SpawnTab = "CurrentPaneDomain"
            })
        },
        {
            key = "w",
            mods = "CTRL",
            action = wezterm.action({
                CloseCurrentTab = {
                    confirm = false
                }
            })
        },
        {
            key = "Tab",
            mods = "CTRL",
            action = wezterm.action({
                ActivateTabRelative = 1
            })
        },
        {
            key = "Tab",
            mods = "CTRL|SHIFT",
            action = wezterm.action({
                ActivateTabRelative = -1
            })
        },
        -- standard copy/paste bindings
        {
            key = "x",
            mods = "CTRL",
            action = "ActivateCopyMode"
        },
        {
            key = "v",
            mods = "CTRL|SHIFT",
            action = wezterm.action({
                PasteFrom = "Clipboard"
            })
        },
        {
            key = "c",
            mods = "CTRL|SHIFT",
            action = wezterm.action({
                CopyTo = "ClipboardAndPrimarySelection"
            })
        } },
    -- TODO: key_tables 在某模式下的keybindings
    -- key_tables = {
    --     activate_pane = {
    --         { key = 'LeftArrow',  action = wezterm.action.ActivatePaneDirection 'Left' },
    --         { key = 'h',          action = wezterm.action.ActivatePaneDirection 'Left' },
    --         { key = 'RightArrow', action = wezterm.action.ActivatePaneDirection 'Right' },
    --         { key = 'l',          action = wezterm.action.ActivatePaneDirection 'Right' },
    --         { key = 'UpArrow',    action = wezterm.action.ActivatePaneDirection 'Up' },
    --         { key = 'k',          action = wezterm.action.ActivatePaneDirection 'Up' },
    --         { key = 'DownArrow',  action = wezterm.action.ActivatePaneDirection 'Down' },
    --         { key = 'j',          action = wezterm.action.ActivatePaneDirection 'Down' },
    --     },
    -- },

    -- X11
    enable_wayland = false,

    -- General
    automatically_reload_config = true,
}
