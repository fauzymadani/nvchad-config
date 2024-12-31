-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "gruvbox",
  --transparency = true,
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}
M.nvdash = {
  load_on_startup = true
}
--TODO: add more plugins


M.diagnostics = function()
  if not rawget(vim, "lsp") then
    return ""
  end

  local err = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.ERROR })
  local warn = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.INFO })

  err = (err and err > 0) and ("%#St_lspError#" .. " " .. err .. " ") or ""
  warn = (warn and warn > 0) and ("%#St_lspWarning#" .. " " .. warn .. " ") or ""
  hints = (hints and hints > 0) and ("%#St_lspHints#" .. "󰛩 " .. hints .. " ") or ""
  info = (info and info > 0) and ("%#St_lspInfo#" .. "󰋼 " .. info .. " ") or ""

  return " " .. err .. warn .. hints .. info
end

M.git = function()
  if not vim.b[M.stbufnr()].gitsigns_head or vim.b[M.stbufnr()].gitsigns_git_status then
    return ""
  end

  local git_status = vim.b[M.stbufnr()].gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
  local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
  local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
  local branch_name = " " .. git_status.head

  return " " .. branch_name .. added .. changed .. removed
end


M.ui = {
  statusline = {
    theme = "vscode_colored",
    separator_style = "default",
  },
  ident = {
    enable = true,
  },

  tabufline = {
    enabled = true,
    show_numbers = true,
  },
  cmp = {
    style = "atom_colored",
    format_colors = {
      tailwind = true,
    },
  },
}
return M
