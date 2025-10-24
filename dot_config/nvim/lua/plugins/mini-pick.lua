return {
  "echasnovski/mini.pick",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.extra",
  },
  config = function()
    local pick = require("mini.pick")
    local extra = require("mini.extra")

    pick.setup({})

    vim.keymap.set("n", "<leader>d", extra.pickers.diagnostic, { desc = "Show diagnostics" })
    vim.keymap.set("n", "<leader>f", pick.builtin.files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>c", pick.registry.resume, { desc = "Resume search" })
    vim.keymap.set("n", "<leader>b", pick.builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>ss", pick.builtin.grep, { desc = "Grep" })
    vim.keymap.set("n", "<leader>sb", extra.pickers.buf_lines, { desc = "Grep in open buffers" })
    vim.keymap.set("n", "<leader>m", extra.pickers.marks, { desc = "Show marks" })
  end,
}
