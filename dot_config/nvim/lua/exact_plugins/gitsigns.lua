return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",

  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      on_attach = function(bufnr)
        -- Actions
        vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
        vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })

        vim.keymap.set("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage hunk" })

        vim.keymap.set("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset hunk" })

        vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
        vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
        vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
        vim.keymap.set("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

        vim.keymap.set("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "Blame line" })
        vim.keymap.set("n", "<leader>hB", gitsigns.blame, { desc = "Blame buffer" })

        vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { desc = "Show diff" })
        vim.keymap.set("n", "<leader>hD", function()
          gitsigns.diffthis("~")
        end, { desc = "Show diff for buffer" })

        -- Text object
        vim.keymap.set({ "o", "x" }, "ah", gitsigns.select_hunk, { desc = "Git hunk" })

        -- Navigation
        vim.keymap.set("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]h", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Next hunk" })

        vim.keymap.set("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[h", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Previous hunk" })
      end,
    })
  end,
}
