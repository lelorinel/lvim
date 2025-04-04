return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({

      blank = {
        enable = false,
      },

      chunk = {
        enable = true,
        error_sign = true,
        notify = true,
      },
      -- indent = {
      --   enable = true,
      -- },
      line_num = {
        enable = true,
      },
    })
  end,
}
