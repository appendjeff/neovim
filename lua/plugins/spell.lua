-- Harper is an offline spelling and grammar checker that runs as an LSP
-- https://writewithharper.com/docs/integrations/neovim
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        harper_ls = {
          settings = {
            ["harper-ls"] = {
              -- Share one dictionary with Neovim's built-in `zg`
              userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
            },
          },
        },
      },
    },
  },
}
