return {
  {
    -- terraform-ls is installed automatically by mason
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "terraform", "hcl" })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
      },
    },
  },
}
