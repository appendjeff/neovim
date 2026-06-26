return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
  -- obsidian.nvim
  -- Comment out this plugin because it is annoying
  --   {
  --     "epwalsh/obsidian.nvim",
  --     version = "*",
  --     lazy = true,
  --     ft = "markdown",
  --     dependencies = { "nvim-lua/plenary.nvim" },
  --     opts = {
  --       workspaces = {
  --         { name = "personal", path = "~/Jammin" }, -- change this path
  --       },
  --       ui = { enable = true },
  --     },
  --   },
}
