-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local api = vim.api

api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "highlight on yank",
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable New Line Comment",
})

api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "go to last loc when opening a buffer",
})

api.nvim_create_autocmd("FileType", {
  pattern = {
    "grug-far",
    "help",
    "man",
    "qf",
    "query",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "close certain windows with q",
})

local chezmoi_path = vim.fn.resolve(vim.fn.expand("~/.local/share/chezmoi"))
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {
    chezmoi_path .. "/**/*", -- files in subdirectories
  },
  callback = function()
    vim.notify("Applying chezmoi changes", vim.log.levels.INFO)
    vim.system({ "chezmoi", "apply", "-k" })
  end,
})

---  NEW CMDS
---@diagnostic disable: param-type-mismatch
-- TODO: 待优化
vim.cmd([[
" use async terminal instead
autocmd BufEnter *.go nnoremap <Leader>rr :AsyncRun -mode=term -pos=bottom -rows=10 go run $(VIM_FILEPATH)<CR>
autocmd BufEnter *.py nnoremap <Leader>rr :AsyncRun -mode=term -pos=bottom -rows=10 python3 $(VIM_FILEPATH)<CR>
autocmd BufEnter *.go nnoremap <Leader>rR :AsyncRun -mode=term -pos=bottom -rows=85 go run $(VIM_FILEPATH)<CR>
autocmd BufEnter *.go nnoremap <Leader>rt :AsyncRun -mode=term -pos=toggleterm2 go run $(VIM_FILEPATH)<CR>
autocmd BufEnter *.go nnoremap <Leader>rT :AsyncRun -mode=term -pos=macos go run $(VIM_FILEPATH)<CR>
autocmd BufEnter *.go nnoremap <Leader>rp :AsyncRun -mode=term -pos=bottom -rows=10 go run .<CR>
autocmd BufEnter *.go nnoremap <Leader>rP :AsyncRun -mode=term -pos=macos -rows=10 go run .<CR>
" autocmd BufEnter *.go nnoremap <Leader>gt :AsyncRun -mode=term -pos=bottom -rows=10 go test $(VIM_FILEPATH)CR>
autocmd BufEnter *.go nnoremap <Leader>gb :AsyncRun -mode=term -pos=bottom -rows=10 go build .<CR>
autocmd BufEnter *.html nnoremap <Leader>rr :AsyncRun -mode=term -pos=bottom -rows=80 miniserve .<CR>
autocmd BufEnter *.markdown nnoremap <C-b> ciw****<left><Esc>P
autocmd BufEnter *.markdown nnoremap <Leader>mp :MarkdownPreview<CR>
autocmd BufEnter *.markdown vnoremap <C-b> c****<left><Esc>P
autocmd BufEnter *.tex nnoremap <Leader>rr :AsyncRun -mode=term -pos=bottom -rows=10 miktex-xelatex % && open -a "Google Chrome" resume_photo.pdf<CR>
]])

vim.cmd([[
" notification after file change
autocmd FileChangedShellPost *
            \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" toggle number style when input mode changed.
"autocmd InsertEnter * set norelativenumber number    " use absolute line number.
"autocmd InsertLeave * set relativenumber

" autocmd FileType zsh set nowrap
" autocmd FileType dashboard :NvimTreeToggle
" autocmd FileType dashboard nmap Q <cmd>qa<CR>

au FileType go set noexpandtab shiftwidth=2 softtabstop=2 tabstop=2

au BufRead,BufNewFile Jenkinsfile,*.jenkins set filetype=groovy

" TODO: set your own python3 path.(LeaderF)
let g:python3_host_prog = "/opt/homebrew/bin/python3.11"

" Clear jumplist on vim Enter
au VimEnter * :clearjumps

]])

-- ------------------------

local augroups = {}

augroups.buf_write_pre = {
  mkdir_before_saving = {
    event = { "BufWritePre", "FileWritePre" },
    pattern = "*",
    -- TODO: Replace vimscript function
    command = [[ silent! call mkdir(expand("<afile>:p:h"), "p") ]],
  },
  trim_extra_spaces_and_newlines = {
    event = "BufWritePre",
    pattern = "*",
    -- TODO: Replace vimscript function
    command = [[
      let current_pos = getpos(".")
      silent! %s/\v\s+$|\n+%$//e
      silent! call setpos(".", current_pos)
    ]],
  },
}

augroups.filetype_behaviour = {
  remove_colorcolumn = {
    event = "FileType",
    pattern = { "fugitive*", "git" },
    callback = function()
      vim.opt_local.colorcolumn = ""
    end,
  },
}

augroups.misc = {
  highlight_yank = {
    event = "TextYankPost",
    pattern = "*",
    callback = function()
      vim.highlight.on_yank({
        higroup = "IncSearch",
        timeout = 200,
        on_visual = true,
      })
    end,
  },
  -- trigger_nvim_lint = {
  --   event = {"BufEnter", "BufNew", "InsertLeave", "TextChanged"},
  --   pattern = "<buffer>",
  --   callback = function ()
  --     require("lint").try_lint()
  --   end,
  -- },
  unlist_terminal = {
    event = "TermOpen",
    pattern = "*",
    callback = function()
      vim.opt_local.buflisted = false
    end,
  },
}

augroups.prose = {
  wrap = {
    event = "FileType",
    pattern = { "markdown", "tex" },
    callback = function()
      vim.opt_local.wrap = true
    end,
  },
}

augroups.quit = {
  quit_with_q = {
    event = "FileType",
    pattern = {
      "checkhealth",
      "fugitive",
      "git*",
      "help",
      "lspinfo",
      "startuptime",
      "qf",
      "TelescopePrompt",
      "neotest-output-panel",
      "neotest-summary",
      -- "dashboard",
      "spectre_panel",
      "neotest-output",
      "blame",
      "grug-far",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
  },
}

-- wrap and check for spell in text filetypes
augroups.wrap_spell = {
  wrap_spell_by_filetype = {
    event = "FileType",
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  },
}

-- resize splits if window got resized
augroups.resize_split = {
  resize_split = {
    event = "VimResized",
    callback = function()
      vim.cmd("tabdo wincmd =")
    end,
  },
}

for group, commands in pairs(augroups) do
  local augroup = vim.api.nvim_create_augroup("AU_" .. group, { clear = true })

  for _, opts in pairs(commands) do
    local event = opts.event
    opts.event = nil
    opts.group = augroup
    vim.api.nvim_create_autocmd(event, opts)
  end
end

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- autosave file when buffer leave or focus lost
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command("silent update")
    end
  end,
})

-- inlay_hint auto enable
vim.api.nvim_create_autocmd("LspAttach", {
  pattern = { "*.go", "*.lua" },
  callback = function(_)
    vim.lsp.inlay_hint.enable()
  end,
})

-- disable semantic highlighting
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

-- auto toggle file explorer when startup nvim
-- vim.cmd([[
-- autocmd VimEnter * execute "normal \<M-n>"
-- ]])

-- if neovide then set background transparent
if vim.g.neovide then
  vim.g.neovide_opacity = 0.8
end

if vim.g.vscode then
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- remap leader key
  keymap("n", "<Space>", "", opts)
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- yank to system clipboard
  keymap({ "n", "v" }, "<leader>y", '"+y', opts)

  -- paste from system clipboard
  keymap({ "n", "v" }, "<leader>p", '"+p', opts)

  -- better indent handling
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)

  -- move text up and down
  keymap("v", "J", ":m .+1<CR>==", opts)
  keymap("v", "K", ":m .-2<CR>==", opts)
  keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
  keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

  -- paste preserves primal yanked piece
  keymap("v", "p", '"_dP', opts)

  -- removes highlighting after escaping vim search
  keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)
end

-- For kitty
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.fn.jobstart({ "kitty", "@", "set-spacing", "padding=0" }, {
      -- padding-left , padding-bottom, margin-*, etc... also can be passed
      detach = true,
      -- detach to make sure it doesn’t interfere with nvim
    })
  end,
})
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.fn.jobstart({ "kitty", "@", "set-spacing", "padding=default" }, {
      --- reset on exit, (default is 25)
      detach = true,
    })
  end,
})
