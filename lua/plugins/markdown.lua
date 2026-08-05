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
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    -- dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      legacy_commands = false,
      picker = { name = "snacks.picker" },
      workspaces = {
        { name = "personal", path = "~/Jammin" }, -- change this path
      },

      link = {
        style = "wiki",
      },

      daily_notes = {
        enabled = true,
        folder = "Daily",
        template = "DailyNoteFormatNVIM.md",
        date_format = "YYYY-MM-DD",
      },
    },
  },
}
