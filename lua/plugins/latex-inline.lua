return {
  'jbyuki/nabla.nvim',
  keys = {
    { '<leader>dp', function() require('nabla').popup() end, desc = 'Show LaTeX popup' },
    { '<leader>dt', function() require('nabla').toggle_virt() end, desc = 'Toggle inline LaTeX' },
  },
}
