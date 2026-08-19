return {
  {
    '3rd/image.nvim',
    opts = {
      backend = 'kitty',
      processor = 'magick_cli',
      integrations = {
        markdown = { enabled = false },
      },
    },
  },
  {
    dir = '/home/josh/sbnc-plantuml',
    dependencies = { '3rd/image.nvim' },
    cmd = {
      'PlantUMLSplitPreview',
      'PlantUMLSplitPreviewRefresh',
      'PlantUMLSplitPreviewClose',
    },
    ft = { 'plantuml' },
    config = function()
      require('plantuml_split_preview').setup {
        split_direction = 'right',
        split_size = 80,
        format = 'png',
        refresh_on_save = true,
        plantuml_cmd = 'plantuml',
        fit_window_to_image = true,
        min_split_size = 30,
        max_split_size = 120,
      }
    end,
  },
}
