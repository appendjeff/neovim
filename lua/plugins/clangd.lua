local function glob1(pattern)
  local matches = vim.fn.glob(vim.fn.expand(pattern), false, true)
  return matches[1]
end

-- Getting clangd to work with my ESP projects
-- See https://github.com/espressif/esp-idf
local esp_clangd = glob1("~/.espressif/tools/esp-clangd/*/esp-clangd/bin/clangd")
local esp_clang_resource_dir = glob1("~/.espressif/tools/esp-clang/*/esp-clang/lib/clang/*")

local cmd
if esp_clangd then
  cmd = {
    esp_clangd,
    "--background-index",
    "--query-driver=" .. (os.getenv("HOME") or "~") .. "/.espressif/**",
  }
  if esp_clang_resource_dir then
    table.insert(cmd, "--resource-dir=" .. esp_clang_resource_dir)
  end
else
  cmd = { "clangd", "--background-index" }
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = { cmd = cmd },
    },
  },
}
