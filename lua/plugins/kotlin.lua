return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.lsp.enable("kmp_lsp")
    end,
    opts = {
      servers = {
        kotlin_language_server = { enabled = false },
        ["*"] = {
          keys = {
            -- Open picker immediately instead of waiting up to 5s for results
            { "gr", function() Snacks.picker.lsp_references({ show_delay = 0 }) end, nowait = true, desc = "References" },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "kotlin" })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        ktfmt = {
          command = "java",
          args = { "-jar", vim.fn.expand("~/bin/ktfmt-0-55.jar"), "--meta-style", "-" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        kotlin = { "ktfmt" },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "kotlin",
        callback = function()
          vim.b.autoformat = true
        end,
      })
    end,
  },
}
