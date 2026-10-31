-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.clipboard = "unnamedplus"

-- Spelling (LazyVim's lazyvim_wrap_spell autocmd turns spell on for prose filetypes)
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions:append("camel")
-- Mix edit-distance and sound-alike scoring for suggestions
vim.opt.spellsuggest = "double,9"
