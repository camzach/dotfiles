vim.pack.add({
  gh("stevearc/oil.nvim"),
  gh("echasnovski/mini.icons"),
})
require("mini.icons").setup()
require("oil").setup({
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, bufnr)
      for component in name:gmatch("[^/]+") do
        if component == ".git" then
          return true
        end
      end
      return false
    end,
  },
})
