vim.pack.add({
  "https://www.github.com/folke/flash.nvim",
})

require("flash").setup()

vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set("o", "gs", function()
  require("flash").treesitter()
end, { desc = "Flash treesitter" })
vim.keymap.set("o", "r", function()
  require("flash").remote()
end, { desc = "Flash remote" })
vim.keymap.set("o", "R", function()
  local register = vim.v.register
  require("flash").treesitter_search({
    action = function(match, state)
      require("flash.jump").remote_op(match, state, register)
    end,
  })
end, { desc = "Flash treesitter remote" })
