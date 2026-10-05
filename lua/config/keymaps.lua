-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Find files in home directory
vim.keymap.set("n", "<leader>fh", function()
  Snacks.picker.files({
    cwd = vim.fn.expand("~"),
    cmd = "fd", -- pin the finder so the args below are valid
    args = { "--max-depth", "6" },
    exclude = { "Library", "node_modules", ".cache" },
  })
end, { desc = "Find files (home dir)" })

-- Reveal the current file in Finder
vim.keymap.set("n", "<leader>fO", function()
  vim.system({ "open", "-R", vim.fn.expand("%:p") })
end, { desc = "Reveal file in Finder" })

-- Add any additional keymaps here
vim.keymap.set("n", "<leader>rr", ":terminal ./gradlew run<CR>", { desc = "Run project" })

-- Close the buffer on backspace
vim.keymap.set("n", "<leader><BS>", ":bd<CR>", { desc = "Close buffer" })

-- Run the python file
vim.keymap.set("n", "<leader>rp", function()
  vim.cmd("split | terminal python3 " .. vim.fn.expand("%"))
end, { desc = "Run python file" })
