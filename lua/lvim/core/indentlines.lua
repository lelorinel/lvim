-- local M = {}

-- M.config = function()
--   lvim.builtin.indentlines = {
--     active = true,
--     on_config_done = nil,
--     options = {
--       enabled = true,
--       buftype_exclude = { "terminal", "nofile" },
--       filetype_exclude = {
--         "help",
--         "startify",
--         "dashboard",
--         "lazy",
--         "neogitstatus",
--         "NvimTree",
--         "Trouble",
--         "text",
--       },
--       char = lvim.icons.ui.LineLeft,
--       context_char = lvim.icons.ui.LineLeft,
--       show_trailing_blankline_indent = false,
--       show_first_indent_level = true,
--       use_treesitter = true,
--       show_current_context = true,
--     },
--   }
-- end

-- M.setup = function()
--   local status_ok, indent_blankline = pcall(require, "indent_blankline")
--   if not status_ok then
--     return
--   end

--   indent_blankline.setup(lvim.builtin.indentlines.options)

--   if lvim.builtin.indentlines.on_config_done then
--     lvim.builtin.indentlines.on_config_done()
--   end
-- end

-- return M


local M = {}

M.config = function()
  lvim.builtin.indentlines = {
    active = true,
    on_config_done = nil,
    options = {
      indent = {
        char = lvim.icons.ui.LineLeft,
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
      },
      exclude = {
        buftypes = { "terminal", "nofile" },
        filetypes = {
          "help",
          "startify",
          "dashboard",
          "lazy",
          "neogitstatus",
          "NvimTree",
          "Trouble",
          "text",
        },
      },
    },
  }
end

M.setup = function()
  local status_ok, ibl = pcall(require, "ibl")
  if not status_ok then
    return
  end

  ibl.setup({
    indent = lvim.builtin.indentlines.options.indent,
    scope = lvim.builtin.indentlines.options.scope,
    exclude = lvim.builtin.indentlines.options.exclude,
  })

  if lvim.builtin.indentlines.on_config_done then
    lvim.builtin.indentlines.on_config_done()
  end
end

return M
