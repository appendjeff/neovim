-- In Claude Code temp buffers, <C-f> inserts an @"file" reference.
-- Scoped to the paths Claude Code uses for EDITOR temp files
-- (/private/tmp on macOS, /tmp on Linux).
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "/private/tmp/claude-*", "/tmp/claude-*" },
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
    local vault = vim.fn.expand(vim.env.OBSIDIAN_HOME)
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

-- Claude Code's "Show last response in external editor" prefixes the prompt
-- buffer with its previous reply as "# " lines. Markdown reads every one of
-- those as an H1, so treesitter colors them like headings. Dim them to Comment
-- so the context block reads as the commentary it is.
-- The matching render-markdown side (full-width heading bars) is handled by the
-- `ignore` option in lua/plugins/markdown.lua, which must match these paths.
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "/private/tmp/claude-*", "/tmp/claude-*" },
  callback = function()
    -- winhighlight is a window-local highlight namespace, so this remaps the
    -- treesitter groups in this window only, leaving other markdown buffers be.
    local remaps = { "@markup.heading:Comment" }
    for level = 1, 6 do
      table.insert(remaps, ("@markup.heading.%d.markdown:Comment"):format(level))
    end
    vim.wo.winhighlight = table.concat(remaps, ",")
  end,
})
