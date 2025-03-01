return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    debug = { enabled = true },
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
    terminal = { enabled = false },
    words = { enabled = true },

    picker = {
      enabled = true,
      layout = {
        cycle = true
      },
      matcher = {
        frecency = true
      }
    },
  },
  keys = {
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit"
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.files({
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
        on_show = function()
          vim.cmd.stopinsert()
        end,
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
        Snacks.picker.git_branches({
          layout = "select",
        })
      end,
      desc = "[S]earch Git [B]ranches"
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.keymaps({
          layout = "vertical",
        })
      end,
      desc = "[S]earch [K]eymaps"
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.git_log({
          finder = "git_log",
          format = "git_log",
          preview = "git_show",
          confirm = "git_checkout",
          layout = "vertical",
        })
      end,
      desc = "[S]earch Git [L]og"
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps({
          layout = "vertical",
        })
      end,
      desc = "[S]earch [K]eymaps"
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep({
          layout = "vertical",
        })
      end,
      desc = "[S]earch [G]rep"
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics_buffer({
          layout = "vertical",
        })
      end,
      desc = "[S]earch [D]iagnostics"
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist({
          layout = "vertical",
        })
      end,
      desc = "[S]earch [Q]uickfix"
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help({
          layout = "vertical",
        })
      end,
      desc = "[S]earch [H]elp"
    },
    {
      "<leader>sz",
      function()
        Snacks.picker.zoxide({
          layout = "vertical",
        })
      end,
      desc = "[S]earch [Z]oxide"
    }
  },
}
