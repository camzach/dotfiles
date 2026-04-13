vim.pack.add({
  gh("windwp/nvim-autopairs"),
  gh("windwp/nvim-ts-autotag"),
})

require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup({ opts = { enable_close_on_slash = true } })
