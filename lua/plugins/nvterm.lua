return {
  'NvChad/nvterm',
  config = function()
    require('nvterm').setup {
      terminals = {
        shell = vim.o.shell,
        list = {},
        type_opts = {
          float = {
            relative = 'editor',
            row = 0.1,
            col = 0.1,
            width = 0.8,
            height = 0.7,
            border = 'single',
          },
          horizontal = { location = 'rightbelow', splitratio = 0.3 },
          vertical = { location = 'rightbelow', splitratio = 0.5 },
        },
        behavior = {
          autoclose_on_quit = {
            enabled = false,
            confirm = true,
          },
          close_on_exit = true,
          auto_insert = true,
        },
      },
    }
    local ft_cmds = {
      python = 'python3' .. vim.fn.expand '%',
    }
    local terminal = require 'nvterm.terminal'
    local toggle_modes = { 'n', 't' }
    local mappings = {
      {
        'n',
        '<C-l>',
        function()
          terminal.send(ft_cmds[vim.bo.filetype])
        end,
      },
      {
        toggle_modes,
        '<A-h>',
        function()
          terminal.toggle 'horizontal'
        end,
      },
      {
        toggle_modes,
        '<A-v>',
        function()
          terminal.toggle 'vertical'
        end,
      },
      {
        toggle_modes,
        '<A-i>',
        function()
          terminal.toggle 'float'
        end,
      },
    }
    local opts = { noremap = true, silent = true }
    for _, mapping in ipairs(mappings) do
      vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
    end
  end,
}
