-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>rr", ":terminal ./gradlew run<CR>", { desc = "Run project" })

-- Close the buffer on backspace
vim.keymap.set("n", "<leader><BS>", ":bd<CR>", { desc = "Close buffer" })

-- Run the python file
vim.keymap.set("n", "<leader>rp", function()
  vim.cmd("split | terminal python3 " .. vim.fn.expand("%"))
end, { desc = "Run python file" })
