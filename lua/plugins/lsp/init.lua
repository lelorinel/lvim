-- return {}

-- local M = {
--   "neovim/nvim-lspconfig",
--   event = { "BufReadPre", "BufNewFile" },
--   dependencies = {
--     -- "hrsh7th/cmp-nvim-lsp",
--   },
-- }
--
-- function M.config()
--   -- require("neodev").setup({})
--   local nvim_lsp = require("lspconfig")
--   -- local configs = require 'lspconfig/configs'
--   -- ------------------
--
--   local on_attach = function(_, bufnr)
--     -- require("lsp-format").on_attach(client)
--     -- require("nvim-navic").attach(client, bufnr)
--
--     -- enable inlay hint
--     -- vim.lsp.buf.inlay_hint(0, true)
--
--     -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--     local opts = { noremap = true, silent = true }
--     local map = vim.api.nvim_buf_set_keymap
--     -- goto preview keymappings
--     map(bufnr, "n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
--     map(bufnr, "n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opts)
--     map(bufnr, "n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", opts)
--     map(bufnr, "n", "gq", "<cmd>lua require('goto-preview').close_all_win()<CR>", opts)
--     map(bufnr, "n", "gF", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opts)
--   end
--   -- nvim-cmp supports additional completion capabilities
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
--   capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true,
--   }
--
--   -- -------------------- general settings -- --------------------
--   vim.diagnostic.config({
--     signs = {
--       text = {
--         [vim.diagnostic.severity.INFO] = " 𝓲",
--         [vim.diagnostic.severity.WARN] = " ❢",
--         [vim.diagnostic.severity.HINT] = " ",
--         [vim.diagnostic.severity.ERROR] = " ✗",
--       },
--       linehl = {
--         [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
--         [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
--         [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
--         [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
--       },
--       numhl = {
--         [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
--         [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
--         [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
--         [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
--       },
--     },
--     update_in_insert = false,
--     underline = true,
--     severity_sort = true,
--     virtual_text = true,
--     virtual_lines = false,
--   })
--
--   -- -------------------------- common lsp server ----------------------
--   local servers = {
--     "bashls",
--     "sqlls",
--     -- 'clangd',
--     -- 'texlab',
--     "dockerls",
--     "marksman",
--     -- 'bufls',
--     "ansiblels",
--     "denols",
--     -- 'pyright',
--   }
--
--   for _, lsp in ipairs(servers) do
--     nvim_lsp[lsp].setup({
--       on_attach = on_attach,
--       capabilities = capabilities,
--       root_dir = function()
--         return vim.fn.getcwd()
--       end,
--     })
--   end
--
--   -- -------------------- python3 lsp settings -- --------------------
--   nvim_lsp.pylsp.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     settings = {
--       pylsp = {
--         plugins = {
--           -- flake8 = {
--           --     enabled = true,
--           -- },
--           rope_autoimport = {
--             enabled = true,
--           },
--           -- rope_completion = {
--           --     enabled = true,
--           -- },
--         },
--       },
--     },
--   })
--   -- -------------------- go lsp settings -- --------------------
--   nvim_lsp.gopls.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     root_dir = nvim_lsp.util.root_pattern("go.mod"),
--     settings = {
--       gopls = {
--         gofumpt = true,
--         usePlaceholders = true,
--         completeUnimported = true,
--         experimentalPostfixCompletions = true,
--         analyses = {
--           unusedparams = true,
--           shadow = true,
--         },
--         hints = {
--           assignVariableTypes = true,
--           compositeLiteralFields = true,
--           compositeLiteralTypes = true,
--           constantValues = true,
--           functionTypeParameters = true,
--           parameterNames = true,
--           rangeVariableTypes = true,
--         },
--         staticcheck = true,
--       },
--     },
--   })
--   -- -------------------- yaml lsp settings -- --------------------
--   -- install yaml-language-server first!!! --  yarn global add yaml-language-server
--   nvim_lsp.yamlls.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { "yaml" },
--     root_dir = function()
--       return vim.fn.getcwd()
--     end,
--     settings = {
--       yaml = {
--         -- schemas = {
--         --     ['file:///Users/agou-ops/.k8s/master-local/all.json'] = '/*.yaml',
--         -- },
--         -- 以下参考自：https://github.com/Allaman/nvim/blob/main/lua/core/plugins/lsp/settings/yaml.lua
--         schemaStore = {
--           enable = true,
--           url = "https://www.schemastore.org/api/json/catalog.json",
--         },
--         schemas = {
--           kubernetes = "*.yaml",
--           ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
--           ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
--           ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines.yml",
--           ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
--           ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
--           ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
--           ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
--           ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
--           ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
--           ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
--           ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
--           ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
--           ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
--         },
--         format = { enabled = false },
--         validate = false,
--         completion = true,
--         hover = true,
--       },
--     },
--     single_file_support = true,
--   })
--
--   -- -------------------- lua lsp settings -- --------------------
--   local settings = {
--     Lua = {
--       hint = { enable = true },
--       runtime = { version = "LuaJIT" },
--       completion = {
--         callSnippet = "Replace",
--       },
--       diagnostics = {
--         globals = {
--           "vim",
--           "use",
--           "describe",
--           "it",
--           "assert",
--           "before_each",
--           "after_each",
--         },
--       },
--       disable = {
--         "lowercase-global",
--         "undefined-global",
--         "unused-local",
--         "unused-function",
--         "unused-vararg",
--         "trailing-space",
--       },
--     },
--   }
--
--   nvim_lsp.lua_ls.setup({
--     on_attach = function(client, bufnr)
--       client.server_capabilities.document_formatting = false
--       client.server_capabilities.document_range_formatting = false
--       on_attach(client, bufnr)
--     end,
--     settings = settings,
--     flags = { debounce_text_changes = 150 },
--     capabilities = capabilities,
--   })
--   -- -------------------- nginx lsp settings -- --------------------
--   local configs = require("lspconfig.configs")
--
--   local root_files = {
--     "default.conf",
--     "nginx.conf",
--   }
--
--   -- Check if the config is already defined (useful when reloading this file)
--   if not configs.nginx_ls then
--     configs.nginx_ls = {
--       default_config = {
--         cmd = { os.getenv("HOME") .. "/.local/share/nvim/mason/bin/nginx-language-server" },
--         filetypes = { "nginx" },
--         root_dir = function(fname)
--           return nvim_lsp.util.root_pattern(unpack(root_files))(fname)
--         end,
--         settings = {},
--       },
--     }
--   end
--   nvim_lsp.nginx_ls.setup({})
--
--   -- -------------------- sql lsp settings -- --------------------
--   nvim_lsp.sqls.setup({
--     settings = {
--       sqls = {
--         connections = {
--           {
--             driver = "mysql",
--             dataSourceName = "root:root@tcp(127.0.0.1:13306)/world",
--           },
--           {
--             driver = "postgresql",
--             dataSourceName = "host=127.0.0.1 port=15432 user=postgres dbname=dvdrental sslmode=disable",
--           },
--         },
--       },
--     },
--   })
--   -- -------------------- html lsp settings -- --------------------
--   capabilities.textDocument.completion.completionItem.snippetSupport = true
--
--   nvim_lsp.html.setup({
--     capabilities = capabilities,
--   })
--   -- -- --------------------------------------------------------------
-- end
--
-- return M

-- lua/plugins/lspconfig.lua

return {
  "neovim/nvim-lspconfig",
  -- event = { "BufReadPre", "BufNewFile" }, -- 'VeryLazy' daha güvenli bir başlangıç noktasıdır.
  event = "VeryLazy",
  dependencies = {
    -- Bu iki eklenti, LSP sunucularını otomatik olarak kurmayı ve yönetmeyi sağlar. Şiddetle tavsiye edilir.
    { "williamboman/mason.nvim", config = true }, -- config = true ile mason.nvim'i otomatik başlatır.
    "williamboman/mason-lspconfig.nvim",

    -- Diğer bağımlılıklarınız
    "hrsh7th/cmp-nvim-lsp",
    "RRethy/goto-preview",
  },
  config = function()
    -- ==========================================================================================
    -- 1. KRİTİK ADIM: Lspsaga'nın çalışması için Neovim'in varsayılan hata gösterimini kapatıyoruz.
    -- ==========================================================================================
    -- Sizin yapılandırmanızda bu 'true' olarak ayarlıydı, bu da sorunun ana kaynağıydı.
    vim.diagnostic.config({
      virtual_text = false, -- !! BURASI EN ÖNEMLİ DEĞİŞİKLİK !!
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Sol taraftaki gutter'da gösterilecek hata ikonlarını ayarla
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- ==========================================================================================
    -- 2. on_attach FONKSİYONU: Tüm LSP sunucuları başladığında çalışacak ortak ayarlar
    -- ==========================================================================================
    local on_attach = function(client, bufnr)
      -- goto-preview tuş atamaları (sizin ayarlarınız korundu)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: " .. desc })
      end

      map("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "Preview Definition")
      map("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "Preview Implementation")
      map("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "Preview Type Definition")
      map("n", "gq", "<cmd>lua require('goto-preview').close_all_win()<CR>", "Close Preview")
      map("n", "gF", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "Preview References")

      -- Diğer LSP tuş atamaları (en sık kullanılanlar)
      map("n", "gd", "<cmd>vim.lsp.buf.definition()<CR>", "Goto Definition")
      map("n", "K", "<cmd>vim.lsp.buf.hover()<CR>", "Hover")
      map("n", "<leader>rn", "<cmd>vim.lsp.buf.rename()<CR>", "Rename")
      map("n", "<leader>ca", "<cmd>vim.lsp.buf.code_action()<CR>", "Code Action")
    end

    -- ==========================================================================================
    -- 3. MASON & LSPCONFIG ENTEGRASYONU: Sunucuları otomatik kur ve yapılandır
    -- ==========================================================================================
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Kurulmasını istediğiniz sunucuların listesi. 'pylsp' yerine 'pyright' genellikle daha iyidir.
    local servers = {
      "bashls",
      "sqlls",
      "dockerls",
      "marksman",
      "ansiblels",
      "denols",
      "gopls",
      "yamlls",
      "lua_ls",
      "nginx_ls",
      "html",
      "pylsp", -- veya "pyright"
    }

    -- mason-lspconfig'in bu sunucuları kurduğundan emin olmasını sağla
    mason_lspconfig.setup({
      ensure_installed = servers,
    })

    -- Her bir sunucu için ortak ayarları (`on_attach` ve `capabilities`) kullanarak yapılandır
    mason_lspconfig.setup_handlers({
      function(server_name)
        -- Sunucuya özel ayarları burada tanımlayabilirsiniz
        local server_opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        -- Go ve Python için sizin özel ayarlarınızı buraya ekliyoruz
        if server_name == "gopls" then
          server_opts.settings = {
            gopls = {
              gofumpt = true,
              usePlaceholders = true,
              completeUnimported = true,
              analyses = { unusedparams = true, shadow = true },
              staticcheck = true,
            },
          }
        end

        if server_name == "pylsp" then
          server_opts.settings = {
            pylsp = {
              plugins = {
                rope_autoimport = { enabled = true },
              },
            },
          }
        end

        if server_name == "lua_ls" then
          server_opts.settings = {
            Lua = {
              diagnostics = { globals = { "vim", "use" } },
            },
          }
        end

        -- Sunucuyu yapılandır
        lspconfig[server_name].setup(server_opts)
      end,
    })
  end,
}
