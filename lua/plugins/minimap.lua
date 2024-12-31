return {
  {
    'echasnovski/mini.map',
    version = '*',
    config = function()
      local map = require('mini.map')

      map.setup({
        -- Highlight integrations
        integrations = nil,

        -- Symbols used to display data
        symbols = {
          -- Encode symbols. Default solid blocks with 3x2 resolution.
          encode = nil,

          -- Scrollbar symbols
          scroll_line = '',
          scroll_view = '',
        },

        -- Window options
        window = {
          -- Non-focusable window
          focusable = false,

          -- Stick to the right side
          side = 'right',

          -- Show count of integration highlights
          show_integration_count = true,

          -- Total width of the minimap
          width = 10,

          -- Transparency
          winblend = 25,

          -- Z-index of the window
          zindex = 10,
        },
      })

      -- Auto start minimap
      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
          map.open()
        end,
      })
    end,
  },
}
