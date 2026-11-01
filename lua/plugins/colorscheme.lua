-- Light/dark mode.
--
-- LazyVim already maps `<leader>ub` to toggle the `background` option, and
-- Neovim re-sources the colorscheme whenever it changes. All that's missing is
-- picking the right tokyonight variant for the current background: the default
-- LazyVim loader calls `tokyonight.load()` with a hardcoded dark style, which
-- forces `background` back to "dark" on startup (tokyonight/init.lua:17) and so
-- would undo the light mode restored in config/options.lua.
return {
  {
    "folke/tokyonight.nvim",
    opts = { light_style = "day" },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("tokyonight").load({ style = vim.o.background == "light" and "day" or "moon" })
      end,
    },
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({
        -- Your config here
      })
    end,
  },
}
