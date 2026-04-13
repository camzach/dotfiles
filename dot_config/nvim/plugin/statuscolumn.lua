vim.pack.add({
  -- gh("kevinhwang91/nvim-ufo"),
  gh("luukvbaal/statuscol.nvim"),
})

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
local builtin = require("statuscol.builtin")
require("statuscol").setup({
  relculright = true,
  segments = {
    {
      sign = { name = { "Marks_.*" }, maxwidth = 1, colwidth = 1, auto = true },
    },
    {
      sign = { namespace = { ".*diagnostic.*" }, maxwidth = 1, colwidth = 1, auto = true },
    },
    { text = { builtin.lnumfunc } },
    {
      sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = true },
    },
    { text = { " " } },
  },
})
-- {
--   "kevinhwang91/nvim-ufo",
--   dependencies = {
--     "kevinhwang91/promise-async",
--   },
--   event = "BufReadPost",
--   opts = {
--     provider_selector = function()
--       return { "treesitter", "indent" }
--     end,
--   },
--
--   init = function()
--     vim.o.foldlevel = 99
--     vim.o.foldmethod = "indent"
--     vim.keymap.set("n", "zR", function()
--       require("ufo").openAllFolds()
--     end)
--     vim.keymap.set("n", "zM", function()
--       require("ufo").closeAllFolds()
--     end)
--   end,
-- },
