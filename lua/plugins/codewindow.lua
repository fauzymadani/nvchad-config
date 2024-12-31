return {
  {
    'gorbit99/codewindow.nvim',
    config = function()
      local codewindow = require('codewindow')
      codewindow.setup({
        auto_enable = true,
        exclude_filetypes = { 'help', 'NvimTree', 'dashboard', 'Nvdash' }, -- Tambahkan 'Nvdash' ke daftar
      })
      codewindow.apply_default_keybinds()

      -- Autocommand untuk mengaktifkan minimap di buffer biasa
      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function()
          if not vim.tbl_contains({ 'Nvdash', 'dashboard' }, vim.bo.filetype) then
            codewindow.open_minimap()
          end
        end,
      })
    end,
  },
}
