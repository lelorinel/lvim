-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Enable powershell as your default shell
-- vim.opt.shell = "pwsh.exe -NoLogo"
-- vim.opt.shellcmdflag =
-- "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
-- vim.cmd [[
-- 		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
-- 		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
-- 		set shellquote= shellxquote=
--   ]]

-- -- Set a compatible clipboard manager
-- vim.g.clipboard = {
--   copy = {
--     ["+"] = "win32yank.exe -i --crlf",
--     ["*"] = "win32yank.exe -i --crlf",
--   },
--   paste = {
--     ["+"] = "win32yank.exe -o --lf",
--     ["*"] = "win32yank.exe -o --lf",
--   },
-- }


-- <Ctrl>f lsp format
--<cmd>lua require('lvim.lsp.utils').format()<cr>
-- if eslint avaible use eslint else use format
lvim.keys.normal_mode["<C-f>"] = function()
  vim.cmd("EslintFixAll")
end
lvim.keys.normal_mode["<C-g>"] = function()
  require('lvim.lsp.utils').format()
end
-- lvim.keys.normal_mode["<C-f>"] = "<cmd>lua require('lvim.lsp.utils').format()<cr>"
lvim.keys.normal_mode["<C-d>"] = "<cmd>EslintFixAll<cr>"
-- eslint --fix
-- lvim.keys.normal_mode["<C-f>"] = "<cmd>!eslint --fix %<CR>"
-- <Ctrl>q left buffer - <Ctrl>e right buffer - <Ctrl>w close current buffer
lvim.keys.normal_mode["<C-w>"] = "<cmd>BufferKill<CR>"
lvim.keys.normal_mode["<C-q>"] = ":bprevious<CR>"
lvim.keys.normal_mode["<C-e>"] = ":bnext<CR>"
-- <CTRL>s save
lvim.keys.normal_mode["<C-s>"] = ":w!<CR>"
-- <Shift>h split left - <Ctrl>l split right
lvim.keys.normal_mode["<S-h>"] = ":split<CR>"
lvim.keys.normal_mode["<S-l>"] = ":vsplit<CR>"
-- <Ctrl>j split down - <Ctrl>k split up
lvim.keys.normal_mode["<S-j>"] = ":split<CR>"
lvim.keys.normal_mode["<S-k>"] = ":vsplit<CR>"
-- <Ctrl>a = :LspStart
lvim.keys.normal_mode["<C-x>"] = ":LspStart<CR>"
-- <Ctrl>1 (Not numpad) start toggleterm <C-F1>
lvim.keys.normal_mode["1"] = ":ToggleTerm direction=float<CR>"
lvim.keys.normal_mode["2"] = ":ToggleTerm direction=horizontal size=20<CR>"
lvim.keys.normal_mode["3"] = ":ToggleTerm direction=vertical size=50<CR>"
lvim.keys.normal_mode["4"] = ":ToggleTerm direction=tab<CR>"
-- if terminal open <Ctrl>1 close terminal ESC close directly
if vim.fn.exists(":ToggleTerm") then
  lvim.keys.normal_mode["1"] = ":ToggleTerm direction=float<CR>"
  lvim.keys.normal_mode["2"] = ":ToggleTerm direction=horizontal<CR>"
  lvim.keys.normal_mode["3"] = ":ToggleTerm direction=vertical<CR>"
  lvim.keys.normal_mode["4"] = ":ToggleTerm direction=tab<CR>"
  lvim.keys.normal_mode["<ESC>"] = "<C-\\><C-n>"
end

lvim.keys.normal_mode["<C-m>"] = ":SymbolsOutline<CR>"

-- <Ctrl>c quit insert mode
lvim.keys.insert_mode["<C-c>"] = "<ESC>"
-- <Ctrl>leader show suggestions
lvim.keys.insert_mode["<C-=>"] = "<C-x><C-o>"



lvim.plugins = {
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require('toggleterm').setup({
        autochdir = true,
      })
    end
  },
  {
    "sainnhe/sonokai"
  },
  {
    "projekt0n/github-nvim-theme"
  },
  { "j-hui/fidget.nvim" },
  { "mrjones2014/legendary.nvim" },
  {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup({
        enable = true,          -- Enable module
        commands = true,        -- Create Focus commands
        autoresize = {
          enable = false,       -- Enable or disable auto-resizing of splits
          width = 0,            -- Force width for the focused window
          height = 0,           -- Force height for the focused window
          minwidth = 0,         -- Force minimum width for the unfocused window
          minheight = 0,        -- Force minimum height for the unfocused window
          height_quickfix = 10, -- Set the height of quickfix panel
        },
        split = {
          bufnew = false, -- Create blank buffer for new split windows
          tmux = false,   -- Create tmux splits instead of neovim splits
        },
        ui = {
          number = false,                    -- Display line numbers in the focussed window only
          relativenumber = false,            -- Display relative line numbers in the focussed window only
          hybridnumber = false,              -- Display hybrid line numbers in the focussed window only
          absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

          cursorline = true,                 -- Display a cursorline in the focussed window only
          cursorcolumn = false,              -- Display cursorcolumn in the focussed window only
          colorcolumn = {
            enable = false,                  -- Display colorcolumn in the foccused window only
            list = '+1',                     -- Set the comma-saperated list for the colorcolumn
          },
          signcolumn = true,                 -- Display signcolumn in the focussed window only
          winhighlight = false,              -- Auto highlighting for focussed/unfocussed windows
        }
      })
    end
  },
  { "utilyre/barbecue.nvim" },
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },
  { "nvim-lua/plenary.nvim" },

  "rebelot/kanagawa.nvim", -- neorg needs a colorscheme with treesitter support
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
    opts = {
      highlight_hovered_item = true,
      show_guides = true,
      auto_preview = false,
      position = 'right',
      relative_width = true,
      width = 25,
      auto_close = false,
      show_numbers = false,
      show_relative_numbers = false,
      show_symbol_details = true,
      preview_bg_highlight = 'Pmenu',
      autofold_depth = nil,
      auto_unfold_hover = true,
      fold_markers = { '', '' },
      wrap = false,
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
        fold = "h",
        unfold = "l",
        fold_all = "W",
        unfold_all = "E",
        fold_reset = "R",
      },
      lsp_blacklist = {},
      symbol_blacklist = {},
      symbols = {
        File = { icon = "", hl = "@text.uri" },
        Module = { icon = "", hl = "@namespace" },
        Namespace = { icon = "", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "𝓒", hl = "@type" },
        Method = { icon = "ƒ", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "ℰ", hl = "@type" },
        Interface = { icon = "ﰮ", hl = "@type" },
        Function = { icon = "", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "𝓐", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "⊨", hl = "@boolean" },
        Array = { icon = "", hl = "@constant" },
        Object = { icon = "⦿", hl = "@type" },
        Key = { icon = "🔐", hl = "@type" },
        Null = { icon = "NULL", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "𝓢", hl = "@type" },
        Event = { icon = "🗲", hl = "@type" },
        Operator = { icon = "+", hl = "@operator" },
        TypeParameter = { icon = "𝙏", hl = "@parameter" },
        Component = { icon = "", hl = "@function" },
        Fragment = { icon = "", hl = "@constant" },
      },
    }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      signs = true,      -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE",         -- The gui style to use for the fg highlight group.
        bg = "BOLD",         -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true,                -- enable multine todo comments
        multiline_pattern = "^.",        -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10,          -- extra lines that will be re-evaluated when changing a line
        before = "",                     -- "fg" or "bg" or empty
        keyword = "wide",                -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",                    -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true,            -- uses treesitter to match keywords in comments only
        max_line_len = 400,              -- ignore lines longer than this
        exclude = {},                    -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    }
  },
  "rockerBOO/boo-colorscheme-nvim",
  "folke/tokyonight.nvim",
  "savq/melange-nvim",
  "scottmckendry/cyberdream.nvim",
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }
    }
  },
  -- {
  --   "rest-nvim/rest.nvim",
  --   ft = "http",
  --   dependencies = { "luarocks.nvim" },
  --   config = function()
  --     require("rest-nvim").setup()
  --   end,
  -- },
  { "EdenEast/nightfox.nvim" },
  { "rose-pine/neovim",      name = "rose-pine" },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "svampkorg/moody.nvim",
    event = { "ModeChanged", "BufWinEnter", "WinEnter" },
    dependencies = {
      -- or whatever "colorscheme" you use to setup your HL groups :)
      -- Colours can also be set within setup, in which case this is redundant.
      "catppuccin/nvim",
    },
    opts = {
      -- you can set different blend values for your different modes.
      -- Some colours might look better more dark, so set a higher value
      -- will result in a darker shade.
      blends = {
        normal = 0.2,
        insert = 0.2,
        visual = 0.25,
        command = 0.2,
        operator = 0.2,
        replace = 0.2,
        select = 0.2,
        terminal = 0.2,
        terminal_n = 0.2,
      },
      -- there are two ways to define colours for the different modes.
      -- one way is to define theme here in colors. Another way is to
      -- set them up with highlight groups. Any highlight group set takes
      -- precedence over any colours defined here.
      colors = {
        normal = "#00BFFF",
        insert = "#70CF67",
        visual = "#AD6FF7",
        command = "#EB788B",
        operator = "#FF8F40",
        replace = "#E66767",
        select = "#AD6FF7",
        terminal = "#4CD4BD",
        terminal_n = "#00BBCC",
      },
      -- disable filetypes here. Add for example "TelescopePrompt" to
      -- not have any coloured cursorline for the telescope prompt.
      disabled_filetypes = { "TelescopePrompt" },
      -- you can turn on or off bold characters for the line numbers
      bold_nr = true,
      -- you can turn on and off a feature which shows a little icon and
      -- registry number at the end of the CursorLine, for when you are
      -- recording a macro! Default is false.
      recording = {
        enabled = false,
        icon = "󰑋",
        -- you can set some text to surround the recording registry char with
        -- or just set one to empty to maybe have just one letter, an arrow
        -- perhaps! For example recording to q, you could have! "󰑋    q" :D
        pre_registry_text = "[",
        post_registry_text = "]",
      },
    },
  },
  {
    'jesseleite/nvim-macroni',
    lazy = false,
    opts = {
      -- All of your `setup(opts)` and saved macros will go here
    },
  },
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },
  {
    'iamyoki/buffer-reopen.nvim',
    opts = {}
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  }
}


local alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
end
if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font:h12"
  vim.g.neovide_transparency = 1
  -- vim.g.neovide_transparency = 0.76
  vim.g.transparency = 0.4
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  -- vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_vfx_mode = "sonicboom"

  -- float blur etc..
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_theme = 'auto'
end

-- -- after start use ':colorscheme sonokai' command
lvim.colorscheme = "cyberdream"
-- hop settings
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

-- Wrap Options
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.list = false

-- vim.cmd('set foldmethod=syntax')
-- trouble vim
-- x is just naming not a keybinding
lvim.builtin.which_key.mappings["x"] = { "", "Trouble" }
lvim.builtin.which_key.mappings["xx"] = {
  function() require("trouble").toggle() end,
  "Trouble"
}
lvim.builtin.which_key.mappings["xw"] = {
  function() require("trouble").toggle("workspace_diagnostics") end,
  "Workspace Diagnostics"
}
lvim.builtin.which_key.mappings["xd"] = {
  function() require("trouble").toggle("document_diagnostics") end,
  "Document Diagnostic"
}
lvim.builtin.which_key.mappings["xq"] = {
  function() require("trouble").toggle("quickfix") end,
  "QuickFix"
}
lvim.builtin.which_key.mappings["xl"] = {
  function() require("trouble").toggle("loclist") end,
  "Location List"
}
lvim.builtin.which_key.mappings["xr"] = {
  function() require("trouble").toggle("lsp_references") end,
  "LSP References"
}
-- TODO
lvim.builtin.which_key.mappings["t"] = { "", "TODO" }
lvim.builtin.which_key.mappings["tl"] = {
  "<cmd>TodoLocList<cr>",
  "Location List"
}
lvim.builtin.which_key.mappings["tq"] = {
  "<cmd>TodoQuickFix<cr>",
  "QuickFix"
}
lvim.builtin.which_key.mappings["tt"] = {
  "<cmd>TodoTelescope<cr>",
  "Document Diagnostic"
}
lvim.builtin.which_key.mappings["tw"] = {
  "<cmd>TodoTrouble<cr>",
  "Trouble"
}


local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
-- Mason LSPconfig ile sunucuları otomatik ata
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      -- highlight enabled
        highlight = {
    enable = true,
    use_languagetree = true,
  },
  autotag = { enable = true },
  rainbow = { enable = true },
  context_commentstring = { enable = true, config = { javascriptreact = { style_element = "{/*%s*/}" } } },
    })
  end,
})

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }

-- vim.opt.fileformats = { "unix" }
