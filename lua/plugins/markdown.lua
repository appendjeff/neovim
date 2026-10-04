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
    -- https://github.com/obsidian-nvim/obsidian.nvim
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    -- dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      legacy_commands = false,
      picker = { name = "snacks.picker" },
      workspaces = {
        { name = "personal", path = "~/obsidian_vaults/JamPackedVault" }, -- change this path
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
  -- This plugin makes rendered markdown look better
  -- https://github.com/MeanderingProgrammer/render-markdown.nvim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "gitcommit" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      enabled = true,
      render_modes = { "n", "c", "t" },
      file_types = { "markdown", "gitcommit" },
      html = { enabled = false },
      completions = { lsp = { enabled = true } },
      checkbox = { enabled = true, checked = { scope_highlight = "@markup.strikethrough" } },
      heading = {
        enabled = true,
        icons = { "" },
        position = "inline",
        width = "full",
        border = true,
        border_virtual = false,
        border_prefix = true,
        above = "___",
        below = "",
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
      },
    },
  },
}
