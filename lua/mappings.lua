require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.keymap.set("n", "<leader>+h", ":resize +5<CR>")
vim.keymap.set("n", "<leader>-h", ":resize -5<CR>")
--vim.keymap.set("n", "<leader>+gs", "<cmd>Gitsigns toggle_current_line_blame<CR>")
vim.keymap.set("n", "<leader>+gs", ":Gitsigns toggle_current_line_blame<CR>")
vim.keymap.set("n", "<Space>nt", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree", silent = true })
vim.keymap.set("n", "<Space>nx", ":Neotree close<CR>", { desc = "Close Neo-tree", silent = true })
vim.keymap.set("n", "<Space>nv", ":Neotree focus<CR>", { desc = "Focus Neo-tree", silent = true })

vim.keymap.set("n", "<Space>tt", ":ToggleTerm<CR>", { desc = "Open Toggle Terminal", silent = true })

--mappings for code runner
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
