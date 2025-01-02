vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

--cursorline
vim.opt.guicursor = "n-v-c-i:block"

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
require("neo-tree").setup({
  source_selector = {
    winbar = true,
    --remove comment to activate status bar
    --statusline = true
  }
})

--require('codewindow').setup()
--require('codewindow').apply_default_keybinds()
--require('mini.map')

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

--function to get active lsp name:
local function get_active_lsp()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if next(clients) == nil then
    --return something if no lsp detected
    return "No LSP"
  end
  local client_names = {}
  for _, client in pairs(clients) do
    table.insert(client_names, client.name)
  end
  return table.concat(client_names, ", ")
end

local navic = require('nvim-navic')
local function on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end
vim.o.winbar = " %{%v:lua.vim.fn.expand('%F')%}  %{%v:lua.require'nvim-navic'.get_location()%}"
require("smear_cursor")
-- lualine
--require("custom.configs.lualine")
--require("custom.configs.lualine-gaps")


--require('lualine').setup {
--  options = {
--    icons_enabled = true,
--    theme = 'auto',
--    component_separators = { left = '|', right = '|' },
--    section_separators = { left = '', right = '' },
--    disabled_filetypes = {
--      statusline = {},
--      winbar = {},
--    },
--    ignore_focus = {},
--    always_divide_middle = true,
--    always_show_tabline = true,
--    globalstatus = false,
--    refresh = {
--    statusline = 100,
--      tabline = 100,
--      winbar = 100,
--    }
--  },
--  sections = {
--    lualine_a = { 'mode' },
--    lualine_b = { 'branch', 'diff', 'diagnostics' },
--   lualine_c = { 'filename' },
--   lualine_x = { 'encoding', 'fileformat', 'filetype', get_active_lsp },
--   lualine_y = { 'progress' },
--   lualine_z = { 'location' }
-- },
-- inactive_sections = {
--   lualine_a = {},
--   lualine_b = {},
--   lualine_c = { 'filename' },
--   lualine_x = { 'location' },
--   lualine_y = {},
--   lualine_z = {}
-- },
-- tabline = {},
-- winbar = {
--   lualine_a = { navic.get_location }, -- Menampilkan nama file
--   lualine_b = {},                     -- Menampilkan cabang git (opsional)
--   lualine_c = {},
--   lualine_x = {},
--   lualine_y = {},
--   lualine_z = {}
-- },
-- inactive_winbar = {},
-- extensions = {}
--}

--code runner configuration
-- nvim navic with lsp
require('lspconfig').clangd.setup {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

require('lspconfig').intelephense.setup {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

require('lspconfig').lua_ls.setup {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

require('lspconfig').taplo.setup {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

require('lspconfig').marksman.setup {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

-- Tailwindcss config Not attach to blade file
require('lspconfig').tailwindcss.setup({
  filetypes = { "html", "css", "javascript", "typescript", "vue", "svelte" }, -- Daftar filetype
  on_attach = function(client, bufnr)
    local file_name = vim.api.nvim_buf_get_name(bufnr)
    if file_name:match("%.blade%.php$") then
      client.stop() -- Matikan LSP untuk file .blade.php
    else
      if file_name:match("%.css") then
        client.stop()
      else
        if file_name:match("%.rs") then
          client.stop()
        end
      end
    end
  end,
})

require('lspconfig').rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}
