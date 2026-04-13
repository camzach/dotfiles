local function map(mode, key, query, desc)
  vim.keymap.set(mode, key, function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end, { desc = desc })
end

vim.pack.add({
  { src = gh("nvim-treesitter/nvim-treesitter"), build = ":TSUpdate" },
  gh("nvim-treesitter/nvim-treesitter-textobjects"),
})

vim.g.no_plugin_maps = true
map({ "x", "o" }, "a=", "@assignment.outer", "Select outer part of an assignment")
map({ "x", "o" }, "i=", "@assignment.inner", "Select inner part of an assignment")
map({ "x", "o" }, "l=", "@assignment.lhs", "Select left hand side of an assignment")
map({ "x", "o" }, "r=", "@assignment.rhs", "Select right hand side of an assignment")
map({ "x", "o" }, "i=", "@assignment.inner", "Select inner part of an assignment")
map({ "x", "o" }, "aa", "@parameter.outer", "Select outer part of a parameter/argument")
map({ "x", "o" }, "ia", "@parameter.inner", "Select inner part of a parameter/argument")
map({ "x", "o" }, "ai", "@conditional.outer", "Select outer part of a conditional")
map({ "x", "o" }, "ii", "@conditional.inner", "Select inner part of a conditional")
map({ "x", "o" }, "al", "@loop.outer", "Select outer part of a loop")
map({ "x", "o" }, "il", "@loop.inner", "Select inner part of a loop")
map({ "x", "o" }, "af", "@call.outer", "Select outer part of a function call")
map({ "x", "o" }, "if", "@call.inner", "Select inner part of a function call")
map({ "x", "o" }, "am", "@function.outer", "Select outer part of a method/function definition")
map({ "x", "o" }, "im", "@function.inner", "Select inner part of a method/function definition")
map({ "x", "o" }, "ac", "@class.outer", "Select outer part of a class")
map({ "x", "o" }, "ic", "@class.inner", "Select inner part of a class")

-- Disabling jsx-element.nvim until issue is resolved
-- Below spec is verbatim from lazy.nvim, needs to be migrated still
-- https://github.com/mawkler/jsx-element.nvim/issues/2
-- {
--   'mawkler/jsx-element.nvim',
--   dependencies = {
--     'nvim-treesitter/nvim-treesitter',
--     'nvim-treesitter/nvim-treesitter-textobjects',
--   },
--   ft = { 'typescriptreact', 'javascriptreact' },
--   opts = { enable = false },
--   config = function()
--     map({ "x", "o" }, "it", "@jsx_element.inner", "Select inner part of a JSX tag")
--     map({ "x", "o" }, "ot", "@jsx_element.outer", "Select outer part of a JSX tag")
--   end
-- }
