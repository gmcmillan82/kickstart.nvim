return {
  'jvgrootveld/telescope-zoxide',
  config = function()
    local t = require 'telescope'
    t.setup {
      extensions = {
        zoxide = {
          prompt_title = '[ Oil Up! ]', -- Any title you like
          mappings = {
            default = {
              -- telescope-zoxide will change directory.
              -- But I'm only using it to get selection.path from telescope UI.
              after_action = function(selection)
                vim.cmd('Oil ' .. selection.path)
                vim.api.nvim_feedkeys('_', '', false)
              end,
            },
          },
        },
      },
    }
    t.load_extension 'zoxide'
    -- This let you only have keymapping attached to oil buffer.
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      pattern = { 'oil://*' },
      callback = function()
        vim.keymap.set('n', '<leader>z', t.extensions.zoxide.list, { desc = 'Jump!', buffer = 0 })
      end,
    })
  end,
}
