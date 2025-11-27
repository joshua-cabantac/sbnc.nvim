return {
  'jbyuki/nabla.nvim',
  config = function()
    -- show inline virtual text rendering for all formulas
    vim.keymap.set('n', '<leader>dp', require('nabla').popup, { desc = 'Show LaTeX popup' })
    vim.keymap.set('n', '<leader>dt', require('nabla').toggle_virt, { desc = 'Toggle inline LaTeX' })
  end,
}
