return {
  dir = '/home/josh/sbnc_dataview',
  config = function()
    local today_number = tonumber(os.date '%Y%m%d')
    require('sbnc_dataview').setup {

      vault_root = '/home/josh/Vault',

      autoeval = {
        enable = true,
        events = { 'BufReadPost', 'BufWritePost' },
        debounce = 0,
      },
      presets = {
        views = {

          tp = {
            title = '▶ To Plan',
            query = 'TASK WHERE !completed AND !due AND (!scheduled or (scheduled and number(dateformat(scheduled, "yyyyMMdd")) < '
              .. today_number
              .. ' )) AND !start AND contains(text, "TD") AND status != "-"',
          },
          td = {
            title = '▶ To Do',
            query = 'task from "" '
              .. 'where !completed AND ( '
              .. '(due AND number(dateformat(due, "yyyyMMdd")) = '
              .. today_number
              .. ' ) or (scheduled AND number(dateformat(scheduled, "yyyyMMdd")) = '
              .. today_number
              .. ')) AND status != "-" '
              .. 'sort due asc',
          },
        },
        keymaps = {
          mappings = {
            ['<leader>td'] = 'td',
            ['<leader>tp'] = 'tp',
          },
        },
      },
      keymaps = {
        enable = true,
        filetypes = { 'markdown', 'norg' },
      },
    }
  end,
}
