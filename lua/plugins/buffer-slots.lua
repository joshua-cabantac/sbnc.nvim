-- Use the local dev copy when it exists (primary machine), otherwise
-- install from GitHub (other machines, e.g. sbnc-laptop).
local function config()
  -- The plugin exposes actions but does not bind keys by default.
  -- Personal bindings:
  local slots = require('sbnc_buffer_slots')

  for i = 1, 9 do
    vim.keymap.set('n', '<leader>' .. i, function()
      slots.switch(i)
    end, { desc = 'Switch to buffer ' .. i })
  end
  vim.keymap.set('n', '<leader>0', function()
    slots.switch(10)
  end, { desc = 'Switch to buffer 10' })

  -- Swap current buffer with slot N: leader + shifted number row.
  -- German/QWERTZ layout: ! = Shift+1 ... ( ) = Shift+8/9, = = Shift+0.
  local swap_keys = { ['1'] = '!', ['2'] = '"', ['3'] = '§', ['4'] = '$', ['5'] = '%', ['6'] = '&', ['7'] = '/', ['8'] = '(', ['9'] = ')' }
  for slot, key in pairs(swap_keys) do
    vim.keymap.set('n', '<leader>' .. key, function()
      slots.swap(tonumber(slot))
    end, { desc = 'Swap current buffer with slot ' .. slot })
  end
  vim.keymap.set('n', '<leader>=', function()
    slots.swap(10)
  end, { desc = 'Swap current buffer with slot 10' })

    vim.keymap.set('n', '<leader>bn', slots.next, { desc = 'Next file buffer' })
    vim.keymap.set('n', '<leader>bp', slots.prev, { desc = 'Previous file buffer' })
    vim.keymap.set('n', '<leader>bl', slots.list, { desc = 'List slots' })
    vim.keymap.set('n', '<leader>br', slots.compact, { desc = 'Compact slots (close gaps)' })
    -- <leader><space> == <leader><leader> (leader is space); replaces telescope's buffers picker
    vim.keymap.set('n', '<leader><space>', function()
      slots.manager({ layout = 'float' })
    end, { desc = 'Open slot manager (oil-style)' })
    vim.keymap.set('n', '<leader>bs', function()
      slots.sidebar()
    end, { desc = 'Toggle slot sidebar' })
    vim.keymap.set('n', '<leader>bo', function()
      -- close all buffers except the current one (skip unsaved changes)
      local cur = vim.api.nvim_get_current_buf()
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if bufnr ~= cur and vim.api.nvim_buf_is_valid(bufnr) then
          pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
        end
      end
    end, { desc = 'Close all buffers but current (buffer only)' })

    -- Reload helper
    vim.keymap.set('n', '<leader>L', function()
      package.loaded['sbnc_buffer_slots'] = nil
      require('sbnc_buffer_slots')
      vim.notify('buffer-slots reloaded')
    end, { desc = 'Reload buffer-slots' })
end

local has_local = vim.fn.isdirectory(vim.fn.expand('~/sbnc-buffer-slots.nvim')) == 1

if has_local then
  return {
    dir = vim.fn.expand('~/sbnc-buffer-slots.nvim'),
    name = 'sbnc-buffer-slots.nvim',
    lazy = false,
    config = config,
  }
end

return {
  'joshua-cabantac/sbnc-buffer-slots.nvim',
  lazy = false,
  config = config,
}
