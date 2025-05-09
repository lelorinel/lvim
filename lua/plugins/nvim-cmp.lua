return {
  "hrsh7th/nvim-cmp",
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local auto_select = true
    return {
      auto_brackets = {}, -- configure any filetype to auto add brackets
      completion = {
        completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
      },
      preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
        ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
        ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
        ["<tab>"] = function(fallback)
          return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
        end,
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "lazydev" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = function(entry, item)
          local lspkind_icons = {
            Text = "",
            Method = "",
            Function = "󰊕",
            Constructor = "󰡱",
            Field = "",
            Variable = "",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = " ",
            Robot = "󱚤",
            Roboti = "󱨚",
            Smiley = " ",
            Note = " ",
          }
          local meta_type = vim_item.kind
          -- load lspkind icons
          vim_item.kind = lspkind_icons[vim_item.kind]
          if entry.source.name == "cmp_tabnine" then
            vim_item.kind = lspkind_icons["Robot"]
            -- vim_item.kind_hl_group = "CmpItemKindTabnine"
          end

          -- if entry.source.name == 'emoji' then
          --     vim_item.kind = lspkind_icons['Smiley']
          --     vim_item.kind_hl_group = 'CmpItemKindEmoji'
          -- end

          if entry.source.name == "look" then
            vim_item.kind = lspkind_icons["Note"]
            -- vim_item.kind_hl_group = "CmpItemKindEmoji"
          end
          -- if entry.source.name == 'codeium' then
          --     vim_item.kind = lspkind_icons['Roboti']
          --     -- vim_item.kind_hl_group = "CmpItemKindEmoji"
          -- end
          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = meta_type,
            path = "[Path]",
            luasnip = "[LuaSnip]",
            cmp_tabnine = "[TN]",
            -- emoji = '[Emoji]',
            look = "[Dict]",
            -- codeium = '[Code]',
          })[entry.source.name]

          return vim_item
          -- local icons = LazyVim.config.icons.kinds
          -- if icons[item.kind] then
          --   item.kind = item.kind .. icons[item.kind]
          -- end
          --
          -- local widths = {
          --   abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
          --   menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
          -- }
          --
          -- for key, width in pairs(widths) do
          --   if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
          --     item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
          --   end
          -- end
          --
          -- return item
        end,
      },
      experimental = {
        -- only show ghost text when we show ai completions
        ghost_text = vim.g.ai_cmp and {
          hl_group = "CmpGhostText",
        } or false,
      },
      sorting = defaults.sorting,
    }
  end,
}
