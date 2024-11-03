vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"
vim.opt.termguicolors = true

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"
--require("custom.configs.alpha")

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "blade",
}

vim.schedule(function()
  require "mappings"
end)

-- Format saat menyimpan file
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.html", "*.css", "*.php", "*.blade.php", "*.lua", "*.c" },
  callback = function()
    vim.lsp.buf.format() -- Menggunakan format() sebagai pengganti formatting_sync
  end,
})

--Lsp buat laravel
local lspconfig = require("lspconfig")

lspconfig.stimulus_ls.setup({
  cmd = { "stimulus-language-server", "--stdio" },
  filetypes = { "blade" }, -- hanya untuk file blade
  root_dir = lspconfig.util.root_pattern("package.json", ".git"),
  settings = {},
})
