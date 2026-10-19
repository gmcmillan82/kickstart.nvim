return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh' },
  opts = {},
  keys = {
    { '<leader>gdo', '<cmd>DiffviewOpen<CR>', desc = 'Open working-tree diff' },
    { '<leader>gds', '<cmd>DiffviewOpen --cached<CR>', desc = 'Staged changes' },
    { '<leader>gdf', '<cmd>DiffviewFileHistory %<CR>', desc = 'File history' },
    { '<leader>gdf', ":<C-u>'<,'>DiffviewFileHistory<CR>", mode = 'x', desc = 'Selected lines history' },
    { '<leader>gdh', '<cmd>DiffviewFileHistory<CR>', desc = 'Repository history' },
    { '<leader>gdq', '<cmd>DiffviewClose<CR>', desc = 'Close Diffview' },
  },
}
