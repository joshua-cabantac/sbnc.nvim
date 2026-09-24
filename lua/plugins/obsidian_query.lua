return {
  {
    'dpezto/obsidian-query.nvim',
    ft = 'markdown',
    opts = {
      picker = {
        backend = 'snacks',
        style = 'rich',
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    opts = function(_, opts)
      opts.custom_handlers = opts.custom_handlers or {}
      opts.custom_handlers.markdown = require('obsidian-query').handler
      opts.custom_handlers.markdown_inline = require('obsidian-query.inline').handler
    end,
  },
}
