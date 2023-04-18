local wezterm = require('wezterm')

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

local kanagawa_colors = {
    foreground = '#dcd7ba',
    background = '#1f1f28',

    cursor_bg = '#c8c093',
    cursor_fg = '#c8c093',
    cursor_border = '#c8c093',

    selection_fg = '#c8c093',
    selection_bg = '#2d4f67',

    scrollbar_thumb = '#16161d',
    split = '#16161d',

    ansi = { '#090618', '#c34043', '#76946a', '#c0a36e', '#7e9cd8', '#957fb8', '#6a9589', '#c8c093' },
    brights = { '#727169', '#e82424', '#98bb6c', '#e6c384', '#7fb4ca', '#938aa9', '#7aa89f', '#dcd7ba' },
    indexed = { [16] = '#ffa066', [17] = "#ff5d62" },

    tab_bar = {
        background = '#1F1F28',

        active_tab = {
            fg_color = '#DCD7BA',
            bg_color = '#363646',

            intensity = 'Bold'
        },

        inactive_tab = {
            fg_color = '#DCD7BA',
            bg_color = '#2A2A37',
        },
        inactive_tab_hover = {
            fg_color = '#DCD7BA',
            bg_color = '#363646',
        },

        new_tab = {
            fg_color = '#DCD7BA',
            bg_color = '#1F1F28'
        },
        new_tab_hover = {
            fg_color = '#DCD7BA',
            bg_color = '#16161D',

            intensity = 'Normal'
        }
    }
}

config.colors = kanagawa_colors
config.force_reverse_video_cursor = true
config.window_background_opacity = 0.95
config.font_size = 16
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

return config
