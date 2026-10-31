return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = { hidden = true, exclude = { "build" } },
        grep = { hidden = true, exclude = { "build" } },
        explorer = { hidden = true },
      },
    },
  },
}
