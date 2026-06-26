-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

--

-- Render the current markdown buffer in glow
--     In markdown buffers, override <C-j> (LazyVim default: move to lower window)
--     to render the current file with `glow -p` in a full-tab terminal. `:!`
--     doesn't reliably give glow a PTY (esp. under noice.nvim), so it falls out
--     of pager mode — termopen always allocates one.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(ev)
    vim.keymap.set("n", "<C-j>", function()
      local file = vim.api.nvim_buf_get_name(ev.buf)
      if file == "" then
        vim.cmd("file")
        return
      end
      if vim.bo[ev.buf].modified then
        vim.cmd("silent! write")
      end
      vim.cmd("tabnew")
      local term_buf = vim.api.nvim_get_current_buf()
      vim.fn.jobstart({ "glow", "-p", file }, {
        term = true,
        on_exit = function()
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(term_buf) then
              vim.api.nvim_buf_delete(term_buf, { force = true })
            end
          end)
        end,
      })
      vim.cmd("startinsert")
    end, { buffer = ev.buf, desc = "Preview with glow (pager)" })
  end,
})

-- In Claude Code temp buffers, <C-f> inserts an @"file" reference.
-- Scoped to /private/tmp/claude-* (the path Claude Code uses for EDITOR temp files).
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "/private/tmp/claude-*",
  callback = function(ev)
    vim.keymap.set("i", "<C-f>", function()
      Snacks.picker.files({
        title = "Insert @file reference",
        confirm = function(picker, item)
          picker:close()
          if item then
            vim.api.nvim_put({ '@"' .. item.file .. '"' }, "c", true, true)
          end
        end,
      })
    end, { buffer = ev.buf, desc = "Insert @file reference for Claude" })
  end,
})

-- In markdown buffers, <C-f> inserts an Obsidian wikilink [[Note Name]]
-- instead of the global Claude Code @"file" style.
-- Searches from the vault root so all notes are reachable.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(ev)
    local vault = vim.fn.expand("~/Jammin")
    local file = vim.api.nvim_buf_get_name(ev.buf)
    if not file:find(vault, 1, true) then
      return
    end
    vim.keymap.set("i", "<C-f>", function()
      Snacks.picker.files({
        title = "Insert [[wikilink]]",
        cwd = vault,
        confirm = function(picker, item)
          picker:close()
          if item then
            local stem = vim.fn.fnamemodify(item.file, ":t:r")
            vim.api.nvim_put({ "[[" .. stem .. "]]" }, "c", true, true)
          end
        end,
      })
    end, { buffer = ev.buf, desc = "Insert [[wikilink]] for Obsidian" })
  end,
})
