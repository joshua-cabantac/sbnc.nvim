local pending_daily_template_time

local function toggle_markdown_checkbox()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = math.max(row, 1)
  local line = vim.api.nvim_get_current_line()
  local prefix, state, suffix = line:match '^(%s*[-*+]%s+)%[([ xX])%](.*)$'

  if state then
    local next_state = state:lower() == 'x' and ' ' or 'x'
    vim.api.nvim_set_current_line(prefix .. '[' .. next_state .. ']' .. suffix)
    return
  end

  local indent, content = line:match '^(%s*)(.*)$'
  local list_prefix, list_content = content:match '^([-*+]%s+)(.*)$'
  if list_prefix then
    vim.api.nvim_set_current_line(indent .. list_prefix .. '[ ] ' .. list_content)
    vim.api.nvim_win_set_cursor(0, { row, col + 4 })
  else
    vim.api.nvim_set_current_line(indent .. '- [ ] ' .. content)
    vim.api.nvim_win_set_cursor(0, { row, col + 6 })
  end
end

local function open_relative_daily(offset)
  local path = vim.api.nvim_buf_get_name(0)
  local year, month, day = path:match '/daily/(%d%d%d%d)%-(%d%d)%-(%d%d)%.md$'
  if not year then
    return
  end

  local timestamp = os.time {
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day) + offset,
    hour = 12,
  }
  pending_daily_template_time = timestamp
  local ok, note = pcall(require('obsidian.daily').daily, { date = timestamp })

  if ok and not note:exists() then
    ok, note = pcall(note.write, note)
  end
  pending_daily_template_time = nil

  if not ok then
    vim.notify(note, vim.log.levels.ERROR)
    return
  end

  note:open()
end

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Vault/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Vault/*.md",
  },
  keys = {
    { '<A-d>', '<cmd>Obsidian today<CR>', desc = "Open today's daily note" },
  },
  init = function()
    local vault = vim.fs.normalize(vim.fn.expand '~/Vault')

    local checkbox_group = vim.api.nvim_create_augroup('VaultMarkdownCheckbox', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = checkbox_group,
      pattern = 'markdown',
      callback = function(args)
        local path = vim.fs.normalize(vim.api.nvim_buf_get_name(args.buf))
        if path ~= vault and not vim.startswith(path, vault .. '/') then
          return
        end

        local opts = { buffer = args.buf, silent = true, desc = 'Add or toggle Markdown checkbox' }
        vim.keymap.set('n', '<C-S-b>', toggle_markdown_checkbox, opts)
        -- Terminals without the extended keyboard protocol cannot distinguish
        -- Ctrl-Shift-B from Ctrl-B, so provide the byte-compatible fallback.
        vim.keymap.set('n', '<C-b>', toggle_markdown_checkbox, opts)
      end,
    })

    local keymap_group = vim.api.nvim_create_augroup('VaultObsidianKeymaps', { clear = true })
    vim.api.nvim_create_autocmd('User', {
      group = keymap_group,
      pattern = 'ObsidianNoteEnter',
      callback = function()
        local opts = { buffer = true, silent = true }
        vim.keymap.set('n', 'gd', '<cmd>Obsidian follow_link<CR>',
          vim.tbl_extend('force', opts, { desc = 'Follow Obsidian link' }))
        vim.keymap.set('n', '<C-l>', 'i[[]]<Left><Left>',
          vim.tbl_extend('force', opts, { desc = 'Insert Obsidian link' }))
        vim.keymap.set('n', '<leader>ob', '<cmd>Obsidian backlinks<CR>',
          vim.tbl_extend('force', opts, { desc = 'Show Obsidian backlinks' }))
        vim.keymap.set('n', '<leader>dd', '<cmd>Obsidian today<CR>',
          vim.tbl_extend('force', opts, { desc = "Open today's daily note" }))
        vim.keymap.set('n', '<leader>dp', function()
          open_relative_daily(-1)
        end, vim.tbl_extend('force', opts, { desc = 'Open previous daily note' }))
        vim.keymap.set('n', '<leader>dn', function()
          open_relative_daily(1)
        end, vim.tbl_extend('force', opts, { desc = 'Open next daily note' }))
      end,
    })

    local cwd = vim.fs.normalize(vim.fn.getcwd())
    if vim.fn.argc() ~= 0 or cwd ~= vault then
      return
    end

    vim.schedule(function()
      require('lazy').load { plugins = { 'obsidian.nvim' } }
      vim.cmd 'Obsidian today'
    end)
  end,
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'vault',
        path = '~/Vault/',
      },
    },
    daily_notes = {
      folder = 'daily',
      date_format = '%Y-%m-%d',
      template = 'Daily Simple',
    },
    templates = {
      folder = 'templates',
      substitutions = {
        date = function(_, suffix)
          local format = suffix or 'YYYY-MM-DD'
          return require('obsidian.util').format_date(pending_daily_template_time or os.time(), format)
        end,
      },
    },
    completion = {
      min_chars = 1,
    },
    cache = {
      enabled = true,
    },
    picker = {
      name = 'snacks.picker',
    },
    ui = {
      enable = false,
    },
    frontmatter = {
      enabled = false,
    },
  },
}
