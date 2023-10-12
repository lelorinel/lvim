-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}

-- <Ctrl>f lsp format
--<cmd>lua require('lvim.lsp.utils').format()<cr>
lvim.keys.normal_mode["<C-f>"] = "<cmd>lua require('lvim.lsp.utils').format()<cr>"
-- <Ctrl>q left buffer - <Ctrl>e right buffer - <Ctrl>w close current buffer
lvim.keys.normal_mode["<C-w>"] = ":bd<CR>"
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
lvim.keys.normal_mode["<C-a>"] = ":LspStart<CR>"
-- <Ctrl>1 (Not numpad) start toggleterm <C-F1>
lvim.keys.normal_mode["1"] = ":ToggleTerm direction=float<CR>"
lvim.keys.normal_mode["2"] = ":ToggleTerm direction=horizontal size=20<CR>"
lvim.keys.normal_mode["3"] = ":ToggleTerm direction=vertical size=50<CR>"
lvim.keys.normal_mode["4"] = ":ToggleTerm direction=tab<CR>"
-- if terminal open <Ctrl>1 close terminal
if vim.fn.exists(":ToggleTerm") then
  lvim.keys.normal_mode["<C-1>"] = ":ToggleTerm direction=float<CR>"
  lvim.keys.normal_mode["<C-2>"] = ":ToggleTerm direction=horizontal<CR>"
  lvim.keys.normal_mode["<C-3>"] = ":ToggleTerm direction=vertical<CR>"
  lvim.keys.normal_mode["<C-4>"] = ":ToggleTerm direction=tab<CR>"
end

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
  {

    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require "octo".setup({
        use_local_fs = false, -- use local files on right side of reviews
        enable_builtin = false, -- shows a list of builtin actions when no action is provided
        default_remote = { "upstream", "origin" }, -- order to try remotes
        ssh_aliases = {}, -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
        reaction_viewer_hint_icon = "", -- marker for user reactions
        user_icon = " ", -- user icon
        timeline_marker = "", -- timeline marker
        timeline_indent = "2", -- timeline indentation
        right_bubble_delimiter = "", -- bubble delimiter
        left_bubble_delimiter = "", -- bubble delimiter
        github_hostname = "", -- GitHub Enterprise host
        snippet_context_lines = 4, -- number or lines around commented lines
        gh_env = {}, -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
        timeout = 5000, -- timeout for requests between the remote server
        ui = {
          use_signcolumn = true, -- show "modified" marks on the sign column
        },
        issues = {
          order_by = {            -- criteria to sort results of `Octo issue list`
            field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction =
            "DESC"                -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
          }
        },
        pull_requests = {
          order_by = {                             -- criteria to sort the results of `Octo pr list`
            field = "CREATED_AT",                  -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction =
            "DESC"                                 -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
          },
          always_select_remote_on_create = "false" -- always give prompt to select base remote repo when creating PRs
        },
        file_panel = {
          size = 10,       -- changed files panel rows
          use_icons = true -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
        },
        mappings = {
          issue = {
            close_issue = { lhs = "<space>ic", desc = "close issue" },
            reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
            list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-r>", desc = "reload issue" },
            open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            add_assignee = { lhs = "<space>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
            create_label = { lhs = "<space>lc", desc = "create label" },
            add_label = { lhs = "<space>la", desc = "add label" },
            remove_label = { lhs = "<space>ld", desc = "remove label" },
            goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
          },
          pull_request = {
            checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
            merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
            squash_and_merge_pr = { lhs = "<space>psm", desc = "squash and merge PR" },
            list_commits = { lhs = "<space>pc", desc = "list PR commits" },
            list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
            show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
            add_reviewer = { lhs = "<space>va", desc = "add reviewer" },
            remove_reviewer = { lhs = "<space>vd", desc = "remove reviewer request" },
            close_issue = { lhs = "<space>ic", desc = "close PR" },
            reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
            list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-r>", desc = "reload PR" },
            open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            goto_file = { lhs = "gf", desc = "go to file" },
            add_assignee = { lhs = "<space>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
            create_label = { lhs = "<space>lc", desc = "create label" },
            add_label = { lhs = "<space>la", desc = "add label" },
            remove_label = { lhs = "<space>ld", desc = "remove label" },
            goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
          },
          review_thread = {
            goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
          },
          submit_win = {
            approve_review = { lhs = "<C-a>", desc = "approve review" },
            comment_review = { lhs = "<C-m>", desc = "comment review" },
            request_changes = { lhs = "<C-r>", desc = "request changes review" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          },
          review_diff = {
            add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
            add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            next_thread = { lhs = "]t", desc = "move to next thread" },
            prev_thread = { lhs = "[t", desc = "move to previous thread" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
            goto_file = { lhs = "gf", desc = "go to file" },
          },
          file_panel = {
            next_entry = { lhs = "j", desc = "move to next changed file" },
            prev_entry = { lhs = "k", desc = "move to previous changed file" },
            select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
            refresh_files = { lhs = "R", desc = "refresh changed files panel" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
          }
        }
      })
    end
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
          enable = true,        -- Enable or disable auto-resizing of splits
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
  -- {
  --   "Dhanus3133/LeetBuddy.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   config = function()
  --     require("leetbuddy").setup({})
  --   end,
  --   keys = {
  --     { "<leader>mq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
  --     { "<leader>ml", "<cmd>LBQuestion<cr>",  desc = "View Question" },
  --     { "<leader>mr", "<cmd>LBReset<cr>",     desc = "Reset Code" },
  --     { "<leader>mt", "<cmd>LBTest<cr>",      desc = "Run Code" },
  --     { "<leader>ms", "<cmd>LBSubmit<cr>",    desc = "Submit Code" },
  --   },
  -- }
}


local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
if vim.g.neovide then
  vim.o.guifont = "Fire Code Retina:h8";
  -- vim.g.neovide_transparency = 0.9
  -- vim.g.transparency = 0.9
  -- vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.neovide_cursor_vfx_mode = "railgun"
end

-- after start use ':colorscheme sonokai' command
lvim.colorscheme = "sonokai"
-- hop settings
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })
