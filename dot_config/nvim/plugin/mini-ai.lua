vim.pack.add({
  "https://www.github.com/echasnovski/mini.ai",
  "https://www.github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

local ai = require("mini.ai")

ai.setup({
  n_lines = 500,
  custom_textobjects = {
    -- Assignments
    ["="] = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }),
    ["L"] = ai.gen_spec.treesitter({ a = "@assignment.lhs", i = "@assignment.lhs" }),
    ["R"] = ai.gen_spec.treesitter({ a = "@assignment.rhs", i = "@assignment.rhs" }),

    -- Code structures
    ["a"] = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
    ["i"] = ai.gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
    ["l"] = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
    ["f"] = ai.gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }),
    ["m"] = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    ["c"] = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
  },
})
