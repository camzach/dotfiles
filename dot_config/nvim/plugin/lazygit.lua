vim.pack.add({
  "https://www.github.com/nvim-lua/plenary.nvim",
  "https://www.github.com/kdheepak/lazygit.nvim",
})

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
