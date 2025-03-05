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
      ensure_installed = {
        "bashls",
        "emmet_language_server",
        "eslint",
        "gopls",
        "jsonls",
        "lua_ls",
        "rust_analyzer",
        "ts_ls",
      },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local opts = { capabilities = capabilities }
    lspconfig.ts_ls.setup({})
    lspconfig.lua_ls.setup({})
    lspconfig.emmet_language_server.setup({})
    lspconfig.eslint.setup({})
    lspconfig.rust_analyzer.setup({})
    lspconfig.jsonls.setup({})
    lspconfig.gopls.setup({})
    lspconfig.bashls.setup({ filetypes = { "sh", "bash", "zsh" } })

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
      },
      virtual_text = true,
      update_in_insert = true,
    })

    vim.diagnostic.config({
      float = {
        format = function(diagnostic)
          if diagnostic.source == "rustc" and diagnostic.user_data.lsp.data ~= nil then
            return diagnostic.user_data.lsp.data.rendered
          else
            return diagnostic.message
          end
        end,
      },
    })
  end,
}
