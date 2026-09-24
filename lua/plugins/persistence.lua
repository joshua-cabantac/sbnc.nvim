return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- load before buffers are restored
  opts = {
    -- save on exit and on SessionLoadPost; restore last session on startup
    options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help' },
  },
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = 'Restore session for current directory',
    },
    {
      '<leader>qS',
      function()
        require('persistence').select()
      end,
      desc = 'Select a session to load',
    },
    {
      '<leader>ql',
      function()
        require('persistence').load({ last = true })
      end,
      desc = 'Restore last session',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = "Don't save current session",
    },
  },
}
