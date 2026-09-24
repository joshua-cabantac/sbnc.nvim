return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    {
      '<leader>e',
      function()
        -- If we're inside a floating window (e.g. the slot manager overlay),
        -- close it first so fullscreen oil replaces the MAIN view instead of
        -- opening inside the tiny overlay.
        if vim.api.nvim_win_get_config(0).relative ~= '' then
          vim.api.nvim_win_close(0, true)
        end
        if vim.bo.filetype == 'oil' then
          vim.cmd 'bdelete'
        else
          require('oil').open()
        end
      end,
      desc = 'Toggle Oil explorer',
    },
  },
  opts = {},
}
