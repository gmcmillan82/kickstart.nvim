-- [[ Setting options ]]
-- See `:help vim.opt`

vim.g.have_nerd_font = true -- Set if you are using a Nerd Font
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.clipboard = 'unnamedplus' -- Use the system clipboard
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history to a file
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Don't ignore case if the search pattern contains uppercase characters
vim.opt.signcolumn = 'yes' -- Always show the sign column
vim.opt.updatetime = 250 -- Faster completion
vim.opt.timeoutlen = 300 -- By default timeoutlen is 1000 ms
vim.opt.splitright = true -- Vertical splits will automatically be to the right
vim.opt.splitbelow = true -- Horizontal splits will automatically be below
vim.opt.list = true -- Show some invisible characters (tabs...)
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- Set listchars
vim.opt.inccommand = 'split' -- Show live preview of substitute
vim.opt.cursorline = true -- Highlight the current line
vim.opt.scrolloff = 10 -- Lines of context
vim.opt.swapfile = false -- No swap file
vim.opt.hlsearch = true -- Highlight search results

-- Set the commentstring for Terraform files
vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('FixTerraformCommentString', { clear = true }),
	callback = function(ev)
		vim.bo[ev.buf].commentstring = '# %s'
	end,
	pattern = { 'terraform', 'hcl' },
})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

