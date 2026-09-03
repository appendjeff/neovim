return {
  "salkin-mada/openscad.nvim",
  ft = "openscad",
  config = function()
    vim.g.openscad_default_mappings = true
    vim.g.openscad_fuzzy_finder = "snacks"
    vim.g.openscad_pdf_cmd = "open"
    require("openscad")
  end,
}
