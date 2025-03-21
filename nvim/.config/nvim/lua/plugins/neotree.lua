return {
    "nvim-neo-tree/neo-tree.nvim",
    version = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        {
            -- only needed if you want to use the commands with "_with_window_picker" suffix
            's1n7ax/nvim-window-picker',
            version = "2.*",
            name = 'window-picker',
            config = function()
                require('window-picker').setup({
                    hint = 'floating-big-letter',
                    filter_rules = {
                        autoselect_one = true,
                        include_current_win = false,
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { 'neo-tree', "neo-tree-popup", "notify", "outline" },

                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { 'terminal', "quickfix" },
                        },
                    },
                    -- other_win_hl_color = '#e35e4f',
                })
            end,
        }
    },
    config = function()
        local highlights = require("neo-tree.ui.highlights")
        local renderer = require "neo-tree.ui.renderer"

        -- Expand a node and load filesystem info if needed.
        local function open_dir(state, dir_node)
            local fs = require "neo-tree.sources.filesystem"
            fs.toggle_directory(state, dir_node, nil, true, false)
        end

        -- Expand a node and all its children, optionally stopping at max_depth.
        local function recursive_open(state, node, max_depth)
            local max_depth_reached = 1
            local stack = { node }
            while next(stack) ~= nil do
                node = table.remove(stack)
                if node.type == "directory" and not node:is_expanded() then
                    open_dir(state, node)
                end

                local depth = node:get_depth()
                max_depth_reached = math.max(depth, max_depth_reached)

                if not max_depth or depth < max_depth - 1 then
                    local children = state.tree:get_nodes(node:get_id())
                    for _, v in ipairs(children) do
                        table.insert(stack, v)
                    end
                end
            end

            return max_depth_reached
        end

        --- Open the fold under the cursor, recursing if count is given.
        local function neotree_zo(state, open_all)
            local node = state.tree:get_node()

            if open_all then
                recursive_open(state, node)
            else
                recursive_open(state, node, node:get_depth() + vim.v.count1)
            end

            renderer.redraw(state)
        end

        --- Recursively open the current folder and all folders it contains.
        local function neotree_zO(state)
            neotree_zo(state, true)
        end

        -- The nodes inside the root folder are depth 2.
        local MIN_DEPTH = 2

        --- Close the node and its parents, optionally stopping at max_depth.
        local function recursive_close(state, node, max_depth)
            if max_depth == nil or max_depth <= MIN_DEPTH then
                max_depth = MIN_DEPTH
            end

            local last = node
            while node and node:get_depth() >= max_depth do
                if node:has_children() and node:is_expanded() then
                    node:collapse()
                end
                last = node
                node = state.tree:get_node(node:get_parent_id())
            end

            return last
        end

        --- Close a folder, or a number of folders equal to count.
        local function neotree_zc(state, close_all)
            local node = state.tree:get_node()
            if not node then
                return
            end

            local max_depth
            if not close_all then
                max_depth = node:get_depth() - vim.v.count1
                if node:has_children() and node:is_expanded() then
                    max_depth = max_depth + 1
                end
            end

            local last = recursive_close(state, node, max_depth)
            renderer.redraw(state)
            renderer.focus_node(state, last:get_id())
        end

        -- Close all containing folders back to the top level.
        local function neotree_zC(state)
            neotree_zc(state, true)
        end

        --- Open a closed folder or close an open one, with an optional count.
        local function neotree_za(state, toggle_all)
            local node = state.tree:get_node()
            if not node then
                return
            end

            if node.type == "directory" and not node:is_expanded() then
                neotree_zo(state, toggle_all)
            else
                neotree_zc(state, toggle_all)
            end
        end

        --- Recursively close an open folder or recursively open a closed folder.
        local function neotree_zA(state)
            neotree_za(state, true)
        end

        --- Set depthlevel, analagous to foldlevel, for the neo-tree file tree.
        local function set_depthlevel(state, depthlevel)
            if depthlevel < MIN_DEPTH then
                depthlevel = MIN_DEPTH
            end

            local stack = state.tree:get_nodes()
            while next(stack) ~= nil do
                local node = table.remove(stack)

                if node.type == "directory" then
                    local should_be_open = depthlevel == nil or node:get_depth() < depthlevel
                    if should_be_open and not node:is_expanded() then
                        open_dir(state, node)
                    elseif not should_be_open and node:is_expanded() then
                        node:collapse()
                    end
                end

                local children = state.tree:get_nodes(node:get_id())
                for _, v in ipairs(children) do
                    table.insert(stack, v)
                end
            end

            vim.b.neotree_depthlevel = depthlevel
        end

        --- Refresh the tree UI after a change of depthlevel.
        -- @bool stay Keep the current node revealed and selected
        local function redraw_after_depthlevel_change(state, stay)
            local node = state.tree:get_node()

            if stay then
                require("neo-tree.ui.renderer").expand_to_node(state.tree, node)
            else
                -- Find the closest parent that is still visible.
                local parent = state.tree:get_node(node:get_parent_id())
                while not parent:is_expanded() and parent:get_depth() > 1 do
                    node = parent
                    parent = state.tree:get_node(node:get_parent_id())
                end
            end

            renderer.redraw(state)
            renderer.focus_node(state, node:get_id())
        end

        --- Update all open/closed folders by depthlevel, then reveal current node.
        local function neotree_zx(state)
            set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
            redraw_after_depthlevel_change(state, true)
        end

        --- Update all open/closed folders by depthlevel.
        local function neotree_zX(state)
            set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
            redraw_after_depthlevel_change(state, false)
        end

        -- Collapse more folders: decrease depthlevel by 1 or count.
        local function neotree_zm(state)
            local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
            set_depthlevel(state, depthlevel - vim.v.count1)
            redraw_after_depthlevel_change(state, false)
        end

        -- Collapse all folders. Set depthlevel to MIN_DEPTH.
        local function neotree_zM(state)
            set_depthlevel(state, MIN_DEPTH)
            redraw_after_depthlevel_change(state, false)
        end

        -- Expand more folders: increase depthlevel by 1 or count.
        local function neotree_zr(state)
            local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
            set_depthlevel(state, depthlevel + vim.v.count1)
            redraw_after_depthlevel_change(state, false)
        end

        -- Expand all folders. Set depthlevel to the deepest node level.
        local function neotree_zR(state)
            local top_level_nodes = state.tree:get_nodes()

            local max_depth = 1
            for _, node in ipairs(top_level_nodes) do
                max_depth = math.max(max_depth, recursive_open(state, node))
            end

            vim.b.neotree_depthlevel = max_depth
            redraw_after_depthlevel_change(state, false)
        end

        -- local kinds = require("symbols")
        require("neo-tree").setup({
            close_if_last_window = true,
            default_component_configs = {
                name = {
                    use_git_status_colors = false,
                },
                icon = {
                    -- folder_closed = kinds["FolderClosed"],
                    -- folder_open = kinds["FolderOpen"],
                    -- folder_empty = kinds["FolderEmpty"],
                    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                    -- then these will never be used.
                    default = "*",
                    highlight = "NeoTreeFileIcon"
                },
                git_status = {
                    symbols = {
                        -- Change type
                        -- added     = kinds["GitAdd"],      -- or "✚", but this is redundant info if you use git_status_colors on the name
                        -- modified  = kinds["GitModified"], -- or "", but this is redundant info if you use git_status_colors on the name
                        -- deleted   = kinds["GitDeleted"],  -- this can only be used in the git_status source
                        -- renamed   = kinds["GitRenamed"],  -- this can only be used in the git_status source
                        -- -- Status type
                        -- untracked = kinds["GitUntracked"],
                        -- ignored   = kinds["GitIgnored"],
                        -- unstaged  = kinds["GitUnstaged"],
                        -- staged    = kinds["GitStaged"],
                        -- conflict  = kinds["GitConflict"],
                    }
                },
            },
            window = {
                position = "right",
                -- width = 40,
            },
            hijack_netrw_behavior = "open_default",
            filesystem = {
                window = {
                    mappings = {
                        ["z"] = "none",

                        ["zo"] = neotree_zo,
                        ["zO"] = neotree_zO,
                        ["zc"] = neotree_zc,
                        ["zC"] = neotree_zC,
                        ["za"] = neotree_za,
                        ["zA"] = neotree_zA,
                        ["zx"] = neotree_zx,
                        ["zX"] = neotree_zX,
                        ["zm"] = neotree_zm,
                        ["zM"] = neotree_zM,
                        ["zr"] = neotree_zr,
                        ["zR"] = neotree_zR,
                    },
                },
                filtered_items = {
                    never_show = { "__pycache__" },
                },
            },
        })
    end,
    keys = {
        { '<leader>nt', ":Neotree toggle<cr>", silent = true, desc = "[N]eotree [T]oggle" },
        { '<leader>nf', ":Neotree focus<cr>",  silent = true, desc = "[N]eotree [F]ocus" }
    }

}
