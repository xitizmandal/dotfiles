local cfg = {
    bind = true,
    doc_lines= 4,
    floating_window = true,
    fix_pos = true,
    hint_enable = true,
    hint_prefix = "🐼 ",
    hint_scheme = "String",
    use_lspsaga = false,
    hi_parameter = "Search",
    max_height = 12,
    max_widht = 120,
    handler_opts = {
        border="none"
    },
    extra_trigger_chars = {}

}
require('lsp_signature').on_attach(cfg)
