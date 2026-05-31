return {
  'catgoose/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    filetypes = { '*' },
    options = {
      parsers = {
        names = { enable = false },
      },
      display = {
        mode = 'background',
      },
    },
  },
}
