vim.pack.add({
  "https://www.github.com/arborist-ts/arborist.nvim",
  "https://www.github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

require("arborist").setup()

vim.g.no_plugin_maps = true
