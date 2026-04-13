vim.pack.add({
  "https://www.github.com/windwp/nvim-autopairs",
  "https://www.github.com/windwp/nvim-ts-autotag",
})

require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup({ opts = { enable_close_on_slash = true } })
