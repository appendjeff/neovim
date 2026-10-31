-- Harper is an offline spelling and grammar checker that runs as an LSP
-- https://writewithharper.com/docs/integrations/neovim
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        harper_ls = {
          enabled = false,
          settings = {
            ["harper-ls"] = {
              -- Share one dictionary with Neovim's built-in spell checker
              -- `zg` is a command to a word to the dictionary
              userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
              diagnosticSeverity = "warning",
            },
          },
          handlers = {
            -- Harper has no "disable all" switch and enables many rules by
            -- default, so keep only spelling diagnostics on the client side
            ["textDocument/publishDiagnostics"] = function(err, result, ctx)
              if result then
                result.diagnostics = vim.tbl_filter(function(diagnostic)
                  return diagnostic.code == "SpellCheck"
                end, result.diagnostics)
              end
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
            end,
          },
        },
      },
    },
  },
}
