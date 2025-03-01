require 'core.keymaps'
require 'core.options'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'plugins.autocompletion',
  require 'plugins.bufferline',
  require 'plugins.colorscheme',
  require 'plugins.copilot',
  require 'plugins.gitsigns',
  require 'plugins.lsp',
  require 'plugins.lualine',
  require 'plugins.misc',
  require 'plugins.neotree',
  -- require 'plugins.nvterm',
  require 'plugins.oil',
  require 'plugins.snacks',
  require 'plugins.treesitter',
  require 'plugins.trouble',
  require 'plugins.unimpaired',
  require 'plugins.vim-tmux-navigator',
  require 'plugins.whichkey',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
