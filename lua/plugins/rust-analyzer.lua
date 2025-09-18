local lspconfig = require("lspconfig")

local on_attach = function(client)
  require("completion").on_attach(client)
end

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      procMacro = {
        enable = true,
      },
    },
  },
})

return {}
