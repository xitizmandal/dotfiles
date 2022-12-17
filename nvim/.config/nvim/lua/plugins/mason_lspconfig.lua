local options = {
    ensure_installed = {
        "pyright",
        "dockerls",
        "bashls",
        "yamlls",
        "tsserver",
        "cssls",
        "robotframework_ls",
        "sumneko_lua",
    },
}

require("mason-lspconfig").setup(options)
