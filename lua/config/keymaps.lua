vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

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
