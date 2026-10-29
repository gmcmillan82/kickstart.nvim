return {
  'akinsho/bufferline.nvim',
  lazy = false,
  keys = {
    { '<leader>B', '<cmd>BufferLineTogglePin<CR>', desc = 'Pin/unpin buffer (Shift+B)' },
    { '<leader>;', '<cmd>BufferLinePick<CR>', desc = 'Pick visible buffer' },
    { '<leader><', '<cmd>BufferLineMovePrev<CR>', desc = 'Move buffer left' },
    { '<leader>>', '<cmd>BufferLineMoveNext<CR>', desc = 'Move buffer right' },
  },
  dependencies = {
    'echasnovski/mini.nvim',
  },
  config = function()
    local function close_buffer(bufnr)
      Snacks.bufdelete(bufnr)
    end

    require('bufferline').setup {
      options = {
        offsets = {
          { filetype = 'snacks_layout_box' },
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
        mode = 'buffers', -- set to "tabs" to only show tabpages instead
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers = 'none', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = close_buffer,
        right_mouse_command = close_buffer,
        buffer_close_icon = '✗',
        close_icon = '✗',
        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 21,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(_, _, diagnostics)
          local icons = require('core.icons').diagnostics
          return (diagnostics.error and icons.Error .. diagnostics.error .. ' ' or '')
            .. (diagnostics.warning and icons.Warn .. diagnostics.warning or '')
        end,
        diagnostics_update_in_insert = false,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = { '│', '│' }, -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = false,
        show_tab_indicators = false,
        indicator = {
          -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'none', -- Options: 'icon', 'underline', 'none'
        },
        groups = {
          items = {
            require('bufferline.groups').builtin.pinned:with { icon = '󰐃' },
          },
        },
        sort_by = 'insert_at_end',
      },
      highlights = {
        separator = {
          fg = '#434C5E',
        },
        buffer_selected = {
          bold = true,
          italic = false,
        },
        -- separator_selected = {},
        -- tab_selected = {},
        -- background = {},
        -- indicator_selected = {},
        -- fill = {},
      },
    }
  end,
}
