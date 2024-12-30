local wezterm = require('wezterm')

local config = {
    automatically_reload_config = true,
    enable_tab_bar = false,
    window_padding = {
        left = 4,
        right = 4,
        top = 4,
        bottom = 4,
    },
    -- color_scheme = 'Tokyo Night',
    color_scheme = 'OneDark (base16)',
    font = wezterm.font 'JetBrainsMono Nerd Font Propo',
    font_size = 13,
    -- harfbuzz_features = {'calt=0', 'clig=0', 'liga=0'},
    -- line_height = 1.05,
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
    window_decorations = "RESIZE",
    audible_bell = "Disabled",
    native_macos_fullscreen_mode = true,
    -- disable_default_key_bindings = true,
    keys = {
        {
            key = 'm',
            mods = 'SUPER',
            action = wezterm.action.DisableDefaultAssignment
        },
        -- { key = 'N', mods = 'CMD|SHIFT', action = wezterm.action.ToggleFullScreen },
        {
            key = 'F',
            mods = 'CTRL|CMD',
            action = wezterm.action.DisableDefaultAssignment
        },
        { key = 'F', mods = 'CMD|SHIFT', action = wezterm.action.ToggleFullScreen },
    },
}

return config
