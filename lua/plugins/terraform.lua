return {
  {
    -- terraform-ls is installed automatically by mason
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {
          -- Fix for https://github.com/hashicorp/terraform-ls/issues/2137
          on_attach = function(client, _)
            client.server_capabilities.semanticTokensProvider = nil
          end,
        },
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
