-- lua/plugins/tmux.lua
-- return {
--   "christoomey/vim-tmux-navigator",
--   lazy = false, -- Her zaman aktif olmalı
--   config = function()
--     vim.g.vim_tmux_navigator_no_mappings = 1
--     vim.keymap.set("n", "<C-h>", "<Cmd>VimTmuxNavigateLeft<CR>", { silent = true })
--     vim.keymap.set("n", "<C-j>", "<Cmd>VimTmuxNavigateDown<CR>", { silent = true })
--     vim.keymap.set("n", "<C-k>", "<Cmd>VimTmuxNavigateUp<CR>", { silent = true })
--     vim.keymap.set("n", "<C-l>", "<Cmd>VimTmuxNavigateRight<CR>", { silent = true })
--   end,
-- }

return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    -- { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}
