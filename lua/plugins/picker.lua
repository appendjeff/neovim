return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
          },
          explorer = {
            hidden = true,
          },
        },
      },
    },
    keys = {
      -- Changed files (staged, unstaged, untracked). <Tab> stages, <C-r> restores.
      {
        "<leader>fg",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Find Files (git status)",
      },
      -- LazyVim's default <leader>fg, moved aside
      -- { "<leader>fG", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
    },
  },
}
