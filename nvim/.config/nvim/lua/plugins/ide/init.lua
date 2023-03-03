local completion = require("plugins.ide.completion")
local debug = require("plugins.ide.debug")
local editor = require("plugins.ide.editor")
local lsp = require("plugins.ide.lsp")
local vcs = require("plugins.ide.vcs")
-- local M = {}

-- M.insert(vcs)
return {
    completion,
    debug,
    editor,
    lsp,
    vcs
}
