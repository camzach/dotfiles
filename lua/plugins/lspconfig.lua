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
      ensure_installed = { "ts_ls", "lua_ls", "emmet_ls", "eslint", "rust_analyzer" },
    })

    lspconfig.ts_ls.setup({})
    lspconfig.lua_ls.setup({})
    lspconfig.emmet_ls.setup({})
    lspconfig.eslint.setup({})
    lspconfig.rust_analyzer.setup({})

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
        header = "",
        focusable = false,
        border = "rounded",
        close_events = {
          "BufLeave",
          "CursorMoved",
          "InsertEnter",
          "FocusLost",
        },
        prefix = "",
        suffix = "",
        format = function(diagnostic)
          if diagnostic.source == "rustc" and diagnostic.user_data.lsp.data ~= nil then
            return diagnostic.user_data.lsp.data.rendered
          else
            return diagnostic.message
          end
        end,
      },
      virtual_text = false,
      update_in_insert = true,
    })
  end,
}
