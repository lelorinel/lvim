-- ---@diagnostic disable: missing-fields
-- local M = {
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   dependencies = {
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-nvim-lsp-signature-help",
--     "saadparwaiz1/cmp_luasnip",
--     "octaltree/cmp-look",
--     "tzachar/cmp-tabnine",
--     "zbirenbaum/copilot.lua",
--     "zbirenbaum/copilot-cmp",
--     "onsails/lspkind-nvim", -- Görsel iyileştirme için eklendi
--   },
-- }
--
-- function M.config()
--   local cmp_status_ok, cmp = pcall(require, "cmp")
--   if not cmp_status_ok then
--     return
--   end
--
--   local lspkind_status_ok, lspkind = pcall(require, "lspkind")
--   if not lspkind_status_ok then
--     return
--   end
--
--   require("copilot").setup({
--     suggestion = { enabled = false },
--     panel = { enabled = false },
--   })
--   require("copilot_cmp").setup()
--
--   -- local luasnip = require("luasnip")
--
--   local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--   end
--
--   cmp.setup({
--     enabled = function()
--       -- Yorum satırlarında otomatik tamamlamayı kapat
--       return not (
--         require("cmp.config.context").in_treesitter_capture("comment") == true
--         or require("cmp.config.context").in_syntax_group("Comment")
--       )
--     end,
--
--     window = {
--       completion = cmp.config.window.bordered(),
--       documentation = cmp.config.window.bordered(),
--     },
--     experimental = {
--       ghost_text = false, -- İsteğe bağlı olarak 'true' yapabilirsiniz.
--     },
--     preselect = cmp.PreselectMode.Item, -- İlk öneriyi seçili ama tamamlanmamış halde tutar
--     completion = {
--       completeopt = "menu,menuone,noinsert",
--     },
--
--     -- (Önceki ayarlarınızda bulunan 'performance', 'matching', 'sorting' bölümlerini
--     -- şimdilik kaldırabilirsiniz. Cmp'nin varsayılanları oldukça iyidir.
--     -- Sorun yaşarsanız adım adım geri ekleyebilirsiniz.)
--
--     formatting = {
--       format = lspkind.cmp_format({
--         mode = "symbol_text",
--         maxwidth = 50,
--         ellipsis_char = "...",
--         menu = {
--           nvim_lsp = "[LSP]",
--           luasnip = "[Snippet]",
--           buffer = "[Buffer]",
--           path = "[Path]",
--           copilot = "[Copilot]",
--           cmp_tabnine = "[Tabnine]",
--           look = "[Dict]",
--           nvim_lsp_signature_help = "[Signature]",
--         },
--       }),
--     },
--
--     mapping = cmp.mapping.preset.insert({
--       ["<C-Space>"] = cmp.mapping.complete(),
--       ["<C-e>"] = cmp.mapping.abort(),
--       ["<CR>"] = cmp.mapping.confirm({ select = true }),
--       ["<C-d>"] = cmp.mapping(function(fallback)
--         if luasnip.expand_or_jumpable() then
--           luasnip.expand_or_jump()
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--       ["<C-f>"] = cmp.mapping(function(fallback)
--         if luasnip.jumpable(-1) then
--           luasnip.jump(-1)
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--       ["<Tab>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           cmp.select_next_item()
--         elseif luasnip.expand_or_jumpable() then
--           luasnip.expand_or_jump()
--         elseif has_words_before() then
--           cmp.complete()
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--       ["<S-Tab>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           cmp.select_prev_item()
--         elseif luasnip.jumpable(-1) then
--           luasnip.jump(-1)
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--     }),
--
--     snippet = {
--       expand = function(args)
--         luasnip.lsp_expand(args.body)
--       end,
--     },
--
--     -- ÖNERİ KAYNAKLARINI YENİDEN SIRALADIK VE GRUPLADIK
--     sources = cmp.config.sources({
--       { name = "nvim_lsp", priority = 1000 },
--       { name = "luasnip", priority = 950 },
--       { name = "copilot", priority = 900 },
--       { name = "cmp_tabnine", priority = 850 },
--       { name = "path", priority = 800 },
--       { name = "nvim_lsp_signature_help", priority = 750, keyword_length = 2 },
--     }, {
--       { name = "buffer", priority = 700, keyword_length = 3 },
--       {
--         name = "look",
--         keyword_length = 4,
--         max_item_count = 5,
--         option = {
--           convert_case = true,
--           loud = true,
--         },
--       },
--     }),
--   })
-- end
--
-- return M

-- lua/plugins/cmp.lua
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp", -- Bu satır burada kalmalı!
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- =========================================================================
    -- !! YENİ EKLENECEK SATIR BURADA !!
    -- LSP 'capabilities' objesini burada oluşturup herkesin erişebileceği
    -- bir alana kaydediyoruz.
    _G.LSP_CAPABILITIES = require("cmp_nvim_lsp").default_capabilities()
    -- =========================================================================

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
