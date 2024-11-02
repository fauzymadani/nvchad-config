return {
  {
    "ast-grep/ast-grep",
    config = function()
      local astgrep = require("ast-grep")

      astgrep.setup({
        -- konfigurasi ast-grep sesuai kebutuhan
      })

      -- Hanya aktifkan untuk file dengan ekstensi `.c`
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "c",
        callback = function()
          astgrep.enable()
        end,
      })

      -- Nonaktifkan ast-grep di file lainnya
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          if vim.bo.filetype ~= "c" then
            astgrep.disable()
          end
        end,
      })
    end,
  }
}
