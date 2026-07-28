return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = { exclude = { "build" } },
        grep = { exclude = { "build" } },
      },
    },
  },
}
