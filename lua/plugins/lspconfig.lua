return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = { "ts_ls", "lua_ls", "emmet_ls", "eslint" },
    })

    lspconfig.ts_ls.setup({})
    lspconfig.lua_ls.setup({})
    lspconfig.emmet_ls.setup({})
    lspconfig.eslint.setup({})
  end,
}
