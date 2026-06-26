-- Blink is an autocomplete plugin
return {
  "saghen/blink.cmp",
  opts = {
    enabled = function()
      return vim.bo.filetype ~= "markdown"
    end,
    sources = {
      default = { "lsp", "path" },
    },
  },
}
