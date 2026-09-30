-- Add languages here, then restart or run `:TSUpdate`.
local ensure_installed = {
  'bash',
  'c',
  'diff',
  'dockerfile',
  'gitignore',
  'go',
  'groovy',
  'html',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'terraform',
  'toml',
  'vim',
  'vimdoc',
  'yaml',
}

return { -- Parsers and queries for Neovim's built-in treesitter
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  -- The `main` branch does not support lazy-loading.
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install(ensure_installed)

    -- On `main`, the plugin only installs parsers; features are enabled per buffer.
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang or not pcall(vim.treesitter.start, args.buf, lang) then
          return
        end
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
