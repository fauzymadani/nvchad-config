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

M.ui = {
  statusline = {
    theme = "minimal",
    separator_style = "block",
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
