return {
  {
    -- go-to-definition, hover docs, completion, signatures, formatting
    -- (binary installed via `cargo install openscad-lsp`)
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        openscad_lsp = {
          -- installed directly via `cargo install openscad-lsp`, not mason
          mason = false,
          -- default root_markers = { ".git" } means it won't start outside
          -- a git repo; fall back to the buffer's own directory
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            on_dir(vim.fs.root(bufnr, ".git") or vim.fs.dirname(fname))
          end,
        },
      },
    },
  },
  {
    "salkin-mada/openscad.nvim",
    ft = "openscad",
    config = function()
      vim.g.openscad_default_mappings = true
      vim.g.openscad_fuzzy_finder = "snacks"
      vim.g.openscad_pdf_cmd = "open"
      require("openscad")

      -- <leader>oh: open the OpenSCAD help picker pre-filtered to the word
      -- under the cursor (help_source/tree file names match keywords like
      -- "cylinder", "hull", "difference", etc).
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "openscad",
        callback = function(args)
          vim.keymap.set("n", "<leader>oh", function()
            local ok, snacks = pcall(require, "snacks")
            if not ok then
              vim.notify("openscad.nvim: snacks.nvim is not installed", vim.log.levels.ERROR)
              return
            end
            local root = require("openscad.utilities").openscad_nvim_root_dir
            snacks.picker.files({
              prompt = "OpenSCAD Help> ",
              cwd = root .. "/help_source/tree",
              pattern = vim.fn.expand("<cword>"),
              title = " OpenSCAD Help ",
            })
          end, { buffer = args.buf, desc = "openscad: help for word under cursor" })
        end,
      })
    end,
  },
}
