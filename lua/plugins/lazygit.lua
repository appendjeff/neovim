-- lazygit -> nvim: open every file a commit touched.
--
-- The `O` custom command in lazygit (see ~/Library/Application Support/lazygit/config.yml)
-- runs, in the commits panel:
--   nvim --server "$NVIM" --remote-expr "v:lua.LazygitOpenCommitFiles('<hash>', '<repo root>')"
-- That loads the commit's files as buffers here, fills the quickfix list (]q / [q)
-- and hides the lazygit float -- lazygit keeps running, so <leader>gg returns to it.
return {
  "folke/snacks.nvim",
  init = function()
    ---@param hash string commit to open
    ---@param root string repo root the commit's paths are relative to
    function _G.LazygitOpenCommitFiles(hash, root)
      vim.schedule(function()
        -- `-m --first-parent` so merge commits list their files too
        local git = vim
          .system({
            "git",
            "-C",
            root,
            "show",
            "--pretty=",
            "--name-status",
            "--diff-filter=d",
            "-m",
            "--first-parent",
            hash,
          }, { text = true })
          :wait()
        if git.code ~= 0 then
          vim.notify(vim.trim(git.stderr or "git show failed"), vim.log.levels.ERROR, { title = "lazygit" })
          return
        end

        local items, seen = {}, {}
        for _, line in ipairs(vim.split(git.stdout or "", "\n", { trimempty = true })) do
          local fields = vim.split(line, "\t", { plain = true })
          local path = root .. "/" .. fields[#fields] -- renames list the new path last
          if not seen[path] and vim.uv.fs_stat(path) then
            seen[path] = true
            items[#items + 1] = { filename = path, lnum = 1, col = 1, text = fields[1] }
          end
        end
        if #items == 0 then
          vim.notify("No files to open in " .. hash:sub(1, 7), vim.log.levels.WARN, { title = "lazygit" })
          return
        end

        -- Get the lazygit float out of the way without killing the process
        for _, term in ipairs(Snacks.terminal.list()) do
          local cmd = term.cmd
          if cmd == "lazygit" or (type(cmd) == "table" and cmd[1] == "lazygit") then
            term:hide()
          end
        end

        for _, item in ipairs(items) do
          vim.bo[vim.fn.bufadd(item.filename)].buflisted = true
        end
        vim.cmd.edit(vim.fn.fnameescape(items[1].filename))
        vim.fn.setqflist({}, " ", { title = "lazygit " .. hash:sub(1, 7), items = items })
        local msg = ("Opened %d file%s from %s"):format(#items, #items == 1 and "" or "s", hash:sub(1, 7))
        vim.notify(msg, vim.log.levels.INFO, { title = "lazygit" })
      end)
      return ""
    end
  end,
}
