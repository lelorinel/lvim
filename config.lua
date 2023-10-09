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
  }
}


local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
if vim.g.neovide then
  vim.o.guifont = "Fire Code Retina:h8";
  -- vim.g.neovide_transparency = 0.8
  -- vim.g.transparency = 0.5
  -- vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.neovide_cursor_vfx_mode = "railgun"
end
