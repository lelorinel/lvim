-- lua/plugins/colorschemes.lua
return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        disable_background = true, -- Disable setting background
        disable_float_background = true, -- Disable setting float background
        disable_italics = true, -- Disable italics
        dark_variant = "moon", -- Options: 'main', 'moon', 'dawn'
      })
    end,
  },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "darker", -- Options: 'darker', 'warmer', 'cooler', 'deep', 'warm', 'light'
        -- transparent = true, -- Enable transparent background
        term_colors = true, -- Enable terminal colors
        ending_tildes = false, -- Show end-of-buffer tildes
        cmp_itemkind_reverse = false, -- Reverse item kind highlights in cmp menu
      })
      -- require("onedark").load()
    end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    config = function()
      -- vim.g.oxocarbon_lua_transparent = true -- Enable transparent background
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled",
          -- transparent = true, -- Enable transparent background
          terminal_colors = true,
          dim_inactive = false,
          module_default = true,
          colorblind = {
            enable = false,
            simulate_only = false,
            severity = {
              protan = 0,
              deutan = 0,
              tritan = 0,
            },
          },
          styles = {
            comments = "NONE",
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
          inverse = {
            match_paren = false,
            visual = false,
            search = false,
          },
        },
      })
    end,
  },
  {
    "rafamadriz/neon",
    config = function()
      vim.g.neon_style = "default"
      -- vim.g.neon_transparent = true -- Enable transparent background
    end,
  },
  {
    "marko-cerovac/material.nvim",
    config = function()
      require("material").setup({
        disable = {
          background = true, -- Enable transparent background
        },
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
    end,
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.g.nightflyTransparent = true -- Enable transparent background
    end,
  },
  {
    "folke/tokyonight.nvim",
    config = function()
      -- require("tokyonight").setup({
      -- transparent = true, -- Enable transparent background
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
      -- })
    end,
  },
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        -- transparent_background = true, -- Enable transparent background
        -- styles = {
        --   sidebars = "transparent",
        --   floats = "transparent",
        -- },
      })
    end,
  },
  { "rebelot/kanagawa.nvim" },
}
