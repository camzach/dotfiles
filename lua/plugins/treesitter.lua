return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = "all",
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true, enable_close_on_slash = false },
    })
  end,
}
