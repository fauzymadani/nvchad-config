-- Load default LSP configurations from NvChad
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local navic = require "nvim-navic"
local nvlsp = require "nvchad.configs.lspconfig"
local capabilities = require("plugins.configs.lspconfig").capabilities

-- Fungsi on_attach khusus untuk semua server LSP
local function on_attach(client, bufnr)
  -- Aktifkan nvim-navic jika server mendukung Document Symbols
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  -- Keybindings tambahan (opsional)
  local opts = { noremap = true, silent = true }
  local buf_set_keymap = vim.api.nvim_buf_set_keymap
  buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
end

-- Konfigurasi winbar untuk menampilkan informasi dari nvim-navic
vim.o.winbar = "%{%v:lua.require'nvim-navic'.is_available() and require'nvim-navic'.get_location() or ''%}"

-- Daftar server LSP yang akan dikonfigurasi
local servers = { "html", "cssls", "tailwindcss", "clangd", "phpactor", "intelephense" }

-- Konfigurasi server LSP secara umum
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,             -- Gunakan fungsi on_attach yang sama
    on_init = nvlsp.on_init,           -- Inisialisasi dari NvChad
    capabilities = nvlsp.capabilities, -- Kemampuan tambahan untuk LSP
  }
end

-- Konfigurasi khusus untuk intelephense
require('lspconfig').intelephense.setup {
  on_attach = on_attach, -- Fungsi on_attach yang sudah didefinisikan
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  settings = {
    intelephense = {
      format = { enable = true }, -- Aktifkan format otomatis
    },
  },
}
vim.o.winbar = "%{%v:lua.require'nvim-navic'.is_available() and require'nvim-navic'.get_location() or ''%}"
