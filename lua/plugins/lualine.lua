return {
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    config = function()
      local mode = {
        'mode',
        fmt = function(str)
          return ' ' .. str
          -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
        end,
      }
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = '|',
          --section_separators = { left = '', right = '' },
          section_separators = { left = ' ', right = ' ' },
        },
        sections = {
          lualine_a = {
            mode,
            'buffers',
          },
          lualine_c = {},
        },
        extensions = {
          'oil',
          'trouble',
        },
      }
    end,
  },
}
