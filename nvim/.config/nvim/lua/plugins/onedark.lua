require('onedark').setup  {
    -- Main options --
    style = 'deep', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
    -- toggle theme style ---
    toggle_style_key = '<leader>ts', -- Default keybinding to toggle
    toggle_style_list = {'light', 'deep'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        functions = 'italic',
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {
        rainbowcol1 = {fg = '$blue', },
        rainbowcol2 = {fg = '$yellow', },
        rainbowcol3 = {fg = '$orange', },
        rainbowcol4 = {fg = '$purple', },
        rainbowcol5 = {fg = '$green', },
        rainbowcol6 = {fg = '$red', },
        rainbowcol7 = {fg = '$grey', },
    }, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = false,    -- use background color for virtual text
    },
}

require('onedark').load()
