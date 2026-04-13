vim.pack.add({
  gh("chentoast/marks.nvim"),
})

require("marks").setup({
  opts = {
    default_mappings = true,
    signs = true, -- Make sure this is enabled
    -- These control the actual mark signs
    mappings = {},
  },
})
