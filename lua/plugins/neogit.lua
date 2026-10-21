return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  dependencies = {
    'sindrets/diffview.nvim',
    'folke/snacks.nvim',
  },
  opts = {
    integrations = {
      diffview = true,
      snacks = true,
    },
  },
  keys = {
    {
      '<leader>ng',
      function()
        local file = vim.api.nvim_buf_get_name(0)
        local cwd = vim.bo.buftype == '' and file ~= '' and vim.fs.dirname(file) or vim.fn.getcwd()
        require('neogit').open({ cwd = cwd, no_expand = true })
      end,
      desc = 'Neogit (current file repository)',
    },
  },
}
