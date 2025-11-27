return {
  'folke/zen-mode.nvim',
  opts = {
    window = {
      width = 0.6,
      options = {
        wrap = true,
        linebreak = true,
        number = true,
        relativenumber = true,
      },
    },
  },
  on_open = function()
    vim.o.showtabline = 2 -- always show tab bar
  end,
  on_close = function()
    vim.o.showtabline = 2 -- keep it visible after closing, too
  end,
  config = function(_, opts)
    require('zen-mode').setup(opts)

    -- Optional: auto-enable Zen Mode for markdown files in your vault
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = vim.fn.expand '~/Vault' .. '/**/*.md',
      callback = function()
        vim.opt.concealcursor = '' -- put it inside callback
        vim.opt.conceallevel = 2
        require('zen-mode').open()
      end,
    })
  end,
}
