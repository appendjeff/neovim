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
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      picker = { name = "snacks.picker" },
      workspaces = {
        { name = "personal", path = "~/Jammin" }, -- change this path
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Daily",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = "DailyNoteFormatNVIM.md",
      },
      templates = {
        folder = "Daily",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },

      -- Completions
      -- Do not use completion! Use my CMD-F macro in autocmds.lua

      ui = { enable = true },
    },
  },
}
