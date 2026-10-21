return {
  'mfussenegger/nvim-lint',
  dependencies = { 'mason.nvim' },
  ft = { 'terraform', 'terraform-vars' },
  config = function()
    local lint = require 'lint'
    local tflint = lint.linters.tflint
    tflint.args = { '--format=json' }
    -- The bundled parser assumes editor cwd and uses one-based diagnostic positions.
    tflint.parser = function(output, bufnr, cwd)
      local result = vim.json.decode(output)
      for _, err in ipairs(result.errors or {}) do
        vim.notify('TFLint: ' .. err.message, vim.log.levels.ERROR)
      end
      local file = vim.uv.fs_realpath(vim.api.nvim_buf_get_name(bufnr))
      local diagnostics = {}
      local severity = {
        warning = vim.diagnostic.severity.WARN,
        error = vim.diagnostic.severity.ERROR,
        notice = vim.diagnostic.severity.INFO,
      }
      for _, issue in ipairs(result.issues or {}) do
        local path = vim.fs.abspath(vim.fs.joinpath(cwd, issue.range.filename))
        if vim.uv.fs_realpath(path) == file then
          diagnostics[#diagnostics + 1] = {
            lnum = issue.range.start.line - 1,
            col = issue.range.start.column - 1,
            end_lnum = issue.range['end'].line - 1,
            end_col = issue.range['end'].column - 1,
            severity = severity[issue.rule.severity],
            source = 'tflint',
            message = issue.message .. ' (' .. issue.rule.name .. ')',
          }
        end
      end
      return diagnostics
    end
    lint.linters_by_ft = {
      terraform = { 'tflint' },
      ['terraform-vars'] = { 'tflint' },
    }
    local function try_lint(args)
      if vim.bo[args.buf].buftype ~= '' then
        return
      end
      local file = vim.api.nvim_buf_get_name(args.buf)
      if file == '' then
        return
      end
      vim.api.nvim_buf_call(args.buf, function()
        lint.try_lint(nil, { cwd = vim.fs.dirname(file) })
      end)
    end
    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
      group = vim.api.nvim_create_augroup('terraform-lint', { clear = true }),
      pattern = { '*.tf', '*.tfvars' },
      callback = try_lint,
    })
    try_lint { buf = vim.api.nvim_get_current_buf() }
  end,
}
