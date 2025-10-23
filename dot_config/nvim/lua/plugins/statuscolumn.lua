return {
  -- UFO folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },

    init = function()
      vim.o.foldlevel = 99
      vim.o.foldmethod = "indent"
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
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
    end,
  },
  -- Folding preview, by default h and l keys are used.
  -- On first press of h key, when cursor is on a closed fold, the preview will be shown.
  -- On second press the preview will be closed and fold will be opened.
  -- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
  -- { "anuvyklack/fold-preview.nvim", dependencies = "anuvyklack/keymap-amend.nvim", config = true },
}
