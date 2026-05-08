return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
  dependencies = {
    'saghen/blink.cmp',
  },
  init = function()
    vim.g.rustaceanvim = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_blink, blink = pcall(require, 'blink.cmp')
      if has_blink then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      return {
        tools = {
          executor = {
            notification = false, -- disables rust-analyzer status messages
          },
        },
        server = {
          cmd = { 'rust-analyzer' },
          capabilities = capabilities,
          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
              },
              check = {
                command = 'clippy',
              },
              checkOnSave = true,
            },
          },
        },
      }
    end
  end,
}
