local wezterm = require('wezterm')

local config = {
    automatically_reload_config = true,
    enable_tab_bar = false,
    window_padding = {
        left = 8,
        right = 8,
        top = 8,
        bottom = 8,
    },
    -- color_scheme = 'Tokyo Night',
    color_scheme = 'OneDark (base16)',
    font = wezterm.font 'JetBrainsMono Nerd Font Propo',
    font_size = 13,
    -- line_height=1.05,
    -- macos_window_background_blur = 30,
    --
    -- window_background_image = '/Users/kshitiz/Pictures/wallpapers/blue_scene.jpg',
    -- window_background_image_hsb = {
    --     -- Darken the background image by reducing it to 1/3rd
    --     brightness = 0.1,
    --
    --     -- You can adjust the hue by scaling its value.
    --     -- a multiplier of 1.0 leaves the value unchanged.
    --     hue = 1.0,
    --
    --     -- You can adjust the saturation also.
    --     saturation = 1.0,
    -- },
    window_background_opacity = 0.90,
    window_decorations = "RESIZE",
}

return config
