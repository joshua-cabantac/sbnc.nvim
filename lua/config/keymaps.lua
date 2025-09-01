vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
-- vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
-- vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
-- vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Open Lazy' })
-- vim.keymap.set('n', '<leader>e', function()
-- vim.keymap.set('n', '<leader>e', function()
--   local netrw_bufname = vim.fn.bufname()
--   if netrw_bufname:match '^netrw' or vim.bo.filetype == 'netrw' then
--     vim.cmd 'b#' -- go to alternate buffer
--   else
--     vim.cmd 'Ex' -- open netrw
--   end
-- end, { desc = 'Toggle netrw' })

-- LSP: Code Action
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: Code Action' })
vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: Code Action' })
vim.keymap.set('n', '<leader>cd', function()
  vim.diagnostic.open_float(0, { scope = 'line' })
end, { desc = 'Show diagnostics for current line' })

vim.keymap.set('n', '<leader>ct', '"zyy"zpa/\27eldt>', { desc = 'Close Tag', noremap = true, silent = true })

-- LSP: Rename
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'LSP: Rename' })

-- Diagnostic: Go to next error
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic' })
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })

-- Switch to last buffer
vim.keymap.set('n', '<leader>bb', '<C-^>', { noremap = true, desc = 'Switch Buffers' })

-- Harpoon
vim.keymap.set('n', '<leader>hh', function()
  Harpoon.ui:toggle_quick_menu(Harpoon:list())
end)

vim.keymap.set('n', '<C-j>', function()
  Harpoon:list():select(1)
end)
vim.keymap.set('n', '<C-k>', function()
  Harpoon:list():select(2)
end)
vim.keymap.set('n', '<C-l>', function()
  Harpoon:list():select(3)
end)
vim.keymap.set('n', '<C-ö>', function()
  Harpoon:list():select(4)
end)
vim.keymap.set('n', '<leader>rj', function()
  Harpoon:list():remove_at(1)
end)
vim.keymap.set('n', '<leader>rk', function()
  Harpoon:list():remove_at(2)
end)
vim.keymap.set('n', '<leader>rl', function()
  Harpoon:list():remove_at(3)
end)
vim.keymap.set('n', '<leader>rö', function()
  Harpoon:list():remove_at(4)
end)

local function set_slot(idx)
  local list = Harpoon:list()
  local item = list.config.create_list_item(list.config, nil) -- nil => current buffer
  list:replace_at(idx, item)
end

-- <leader>a{j,k,l,ö} => slots 1..4
vim.keymap.set('n', '<leader>aj', function()
  set_slot(1)
end, { desc = 'Harpoon: set slot 1' })
vim.keymap.set('n', '<leader>ak', function()
  set_slot(2)
end, { desc = 'Harpoon: set slot 2' })
vim.keymap.set('n', '<leader>al', function()
  set_slot(3)
end, { desc = 'Harpoon: set slot 3' })
vim.keymap.set('n', '<leader>aö', function()
  set_slot(4)
end, { desc = 'Harpoon: set slot 4' })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set('n', '<C-S-P>', function()
  Harpoon:list():prev()
end)
vim.keymap.set('n', '<C-S-N>', function()
  Harpoon:list():next()
end)
