return {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  cmd = 'ConformInfo',
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true }
      end,
      mode = { 'n', 'x' },
      desc = 'Format buffer or selection',
    },
  },
  opts = {
    notify_on_error = true,
    notify_no_formatters = true,
    default_format_opts = { lsp_format = 'fallback' },
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      yaml = { 'yamlfix' },
      ['yaml.docker-compose'] = { 'yamlfix' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      markdown = { 'prettier' },
    },
  },
}
