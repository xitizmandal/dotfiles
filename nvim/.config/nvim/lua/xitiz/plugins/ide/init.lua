local completion = require("xitiz.plugins.ide.completion")
local debug = require("xitiz.plugins.ide.debug")
local editor = require("xitiz.plugins.ide.editor")
local lsp = require("xitiz.plugins.ide.lsp")
local vcs = require("xitiz.plugins.ide.vcs")
-- local M = {}

-- M.insert(vcs)
return {
    completion,
    debug,
    editor,
    lsp,
    vcs
}
