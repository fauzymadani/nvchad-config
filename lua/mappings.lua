require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.keymap.set("n", "<leader>+h", ":resize +5<CR>")
vim.keymap.set("n", "<leader>-h", ":resize -5<CR>")
--vim.keymap.set("n", "<leader>+gs", "<cmd>Gitsigns toggle_current_line_blame<CR>")
vim.keymap.set("n", "<leader>+gs", ":Gitsigns toggle_current_line_blame<CR>")
-- Key mapping untuk membuka Neo-tree
vim.keymap.set("n", "<Space>nt", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
