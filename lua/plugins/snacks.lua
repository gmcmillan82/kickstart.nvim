local function project_cwd()
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)
  if vim.bo[buf].buftype == "" and file ~= "" then
    return Snacks.git.get_root(file) or vim.fn.getcwd()
  end
  return vim.fn.getcwd()
end

local function history_options()
  return {
    cwd = project_cwd(),
    confirm = function(picker, item)
      if not item or not item.commit or not item.cwd then
        Snacks.notify.warn("No commit selected", { title = "Git history" })
        return
      end
      picker:close()
      require("lazy").load({ plugins = { "diffview.nvim" } })
      local args = { "-C" .. item.cwd, item.commit .. "^!" }
      if item.file then
        vim.list_extend(args, { "--", item.file })
      end
      require("diffview").open(args)
    end,
    win = {
      input = {
        keys = {
          ["<C-y>"] = { "git_checkout", mode = { "n", "i" }, desc = "Checkout selected commit/file" },
        },
      },
    },
  }
end

local function toggle_terminal()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].buftype == "terminal" then
    for _, terminal in ipairs(Snacks.terminal.list()) do
      if terminal.buf == buf then
        terminal:hide()
        return
      end
    end
  end
  local file = vim.api.nvim_buf_get_name(buf)
  local cwd = vim.bo[buf].buftype == "" and file ~= "" and vim.fs.dirname(file) or vim.fn.getcwd()
  Snacks.terminal.toggle(nil, { cwd = cwd, win = { position = "bottom", height = 0.3 } })
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    debug = { enabled = true },
    explorer = {
      enabled = true,
      replace_netrw = false,
    },
    indent = {
      enabled = true,
      chunk = {
        enabled = true,
      }
    },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    notify = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    words = { enabled = true },
    gh = { enabled = true },
    toggle = { enabled = true },

    picker = {
      enabled = true,
      icons = {
        diagnostics = require("core.icons").diagnostics,
        kinds = require("core.icons").kinds,
      },
      sources = {
        explorer = {
          hidden = true,
          ignored = false,
          layout = { cycle = false },
        },
        files = { hidden = true, ignored = false },
        grep = { hidden = true, ignored = false },
        grep_word = { hidden = true, ignored = false },
        smart = { hidden = true, ignored = false },
        projects = { dev = { "~/Code" } },
      },
      layout = {
        preset = "telescope",
        cycle = true
      },
      matcher = {
        frecency = true
      },
      focus = "input"
    },
  },
  keys = {
    {
      "\\",
      function()
        Snacks.explorer({ cwd = project_cwd() })
      end,
      desc = "Snacks Explorer (Shift+E)"
    },
    {
      "<leader>tt",
      toggle_terminal,
      desc = "Toggle terminal"
    },
    {
      "<C-/>",
      toggle_terminal,
      mode = { "n", "t" },
      desc = "Toggle terminal"
    },
    {
      "<leader>gr",
      function()
        Snacks.gitbrowse({ what = "repo" })
      end,
      desc = "Git Browse Repository"
    },
    {
      "<leader>gb",
      function()
        Snacks.gitbrowse({ what = "branch" })
      end,
      desc = "Git Browse Branch"
    },
    {
      "<leader>gf",
      function()
        Snacks.gitbrowse({ what = "file" })
      end,
      mode = { "n", "x" },
      desc = "Git Browse File"
    },
    {
      "<leader>gc",
      function()
        Snacks.gitbrowse({ what = "commit" })
      end,
      desc = "Git Browse Commit under Cursor"
    },
    {
      "<leader>gF",
      function()
        Snacks.gitbrowse({ what = "permalink" })
      end,
      mode = { "n", "x" },
      desc = "Git Browse File Permalink"
    },
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit"
    },
    {
      "<leader>gi",
      function()
        Snacks.picker.gh_issue()
      end,
      desc = "GitHub Issues (open)"
    },
    {
      "<leader>gI",
      function()
        Snacks.picker.gh_issue({
          state = "all"
        })
      end,
      desc = "GitHub Issues (all)"
    },
    {
      "<leader>gp",
      function()
        Snacks.picker.gh_pr()
      end,
      desc = "GitHub Pull Request (open)"
    },
    {
      "<leader>gP",
      function()
        Snacks.picker.gh_pr({
          state = "all"
        })
      end,
      desc = "GitHub Pull Request (all)"
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.files({
          cwd = project_cwd(),
          finder = "files",
          format = "file",
          show_empty = true,
          supports_live = true,
        })
      end,
      desc = "[S]earch [F]iles"
    },
    {
      "<leader>sn",
      function()
        Snacks.picker.files({
          cwd = vim.fn.stdpath("config")
        })
      end,
      desc = "[N]eovim config"
    },
    {
      "<leader><leader>",
      function() Snacks.picker.buffers({
        finder = "buffers",
        format = "buffer",
        hidden = false,
        unloaded = true,
        current = true,
        sort_lastused = true,
        win = {
          input = {
            keys = {
              ["d"] = "bufdelete"
            },
          },
          list = { keys = { ["d"] = "bufdelete" } },
        },
      })
      end,
      desc = "[ ] Find existing buffers"
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.git_branches({ cwd = project_cwd() })
      end,
      desc = "[S]earch Git [B]ranches"
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.git_log(history_options())
      end,
      desc = "[S]earch Git Log (l)"
    },
    {
      "<leader>sf",
      function()
        Snacks.picker.git_log_file(history_options())
      end,
      desc = "[S]earch Git [F]ile History"
    },
    {
      "<leader>sL",
      function()
        Snacks.picker.git_log_line(history_options())
      end,
      desc = "[S]earch Git Line History (Shift+L)"
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "[S]earch [K]eymaps"
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep({ cwd = project_cwd() })
      end,
      desc = "[S]earch [G]rep"
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "[S]earch [D]iagnostics"
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "[S]earch [Q]uickfix"
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "[S]earch [H]elp"
    },
    {
      "<leader>sz",
      function()
        Snacks.picker.zoxide()
      end,
      desc = "[S]earch [Z]oxide"
    },
    {
      "<leader>s?",
      function()
        Snacks.picker.pickers()
      end,
      desc = "Search available pickers (?)"
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume last picker (Shift+R)"
    },
    {
      "<leader>sr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Search recent files (r)"
    },
    {
      "<leader>sS",
      function()
        Snacks.picker.smart({ cwd = project_cwd() })
      end,
      desc = "Smart file search (Shift+S)"
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.lines({ layout = { preset = "telescope", preview = true } })
      end,
      desc = "Search current buffer (/)"
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word({ cwd = project_cwd() })
      end,
      desc = "Search word under cursor (w)"
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Search workspace diagnostics (Shift+D)"
    },
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = 'Search registers (")'
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Search undo history (u)"
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history({ layout = { preset = "telescope" } })
      end,
      desc = "Search command history (c)"
    },
    {
      "<leader>sN",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Search notifications (Shift+N)"
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Search projects (p)"
    },
  }
}
