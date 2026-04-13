vim.pack.add({
  gh("williamboman/mason.nvim"),
  gh("williamboman/mason-lspconfig.nvim"),
  gh("neovim/nvim-lspconfig"),
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "biome",
    "emmet_language_server",
    "eslint",
    "gopls",
    "hls",
    "jsonls",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "stylelint_lsp",
    "tailwindcss",
    "taplo",
    "ts_ls",
  },
})

vim.lsp.config("bashls", {
  filetypes = { "sh", "bash", "zsh" },
})

vim.o.winborder = "rounded"
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.HINT] = "󰌶",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  float = {
    border = "rounded",
    format = function(diagnostic)
      if diagnostic.source == "rustc" and diagnostic.user_data.lsp.data ~= nil then
        return diagnostic.user_data.lsp.data.rendered
      else
        return diagnostic.message
      end
    end,
  },
  virtual_text = true,
  update_in_insert = true,
})
