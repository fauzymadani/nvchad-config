require 'nvim-treesitter.configs'.setup {
    -- Konfigurasi untuk Treesitter
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    ensure_installed = { "php", "blade" }, -- tambahkan sesuai kebutuhan bahasa lainnya
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
    install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
    },
    filetype = "blade",
}

