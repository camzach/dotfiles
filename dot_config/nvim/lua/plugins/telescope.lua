local function live_grep_in_directory()
  local builtin = require("telescope.builtin")

  builtin.find_files({
    prompt_title = "Select Directory (press <CR> to grep in)",
    find_command = { "find", ".", "-type", "d", "-not", "-path", "*/.*" },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      map("i", "<CR>", function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if selection then
          builtin.live_grep({
            prompt_title = "Live Grep in " .. selection.value,
            cwd = selection.value,
            theme = "ivy",
          })
        end
      end)

      return true
    end,
  })
end

local function live_grep_in_open_buffers()
  local builtin = require("telescope.builtin")
  builtin.live_grep({
    prompt_title = "Live Grep in Open Buffers",
    grep_open_files = true,
    theme = "ivy",
  })
end

return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "bottom",
        width = 0.9,
        height = 0.4,
        preview_width = 0.6,
      },
      preview = false,
      border = true,
      borderchars = {
        prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
      prompt_prefix = "> ",
      selection_caret = "> ",
    },
    pickers = {
      current_buffer_fuzzy_find = { preview = true },
      diagnostics = { preview = true },
      live_grep = { preview = true },
      marks = { preview = true },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("ui-select")
  end,
  keys = {
    { "<leader>z", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "File fuzzy find" },
    { "<leader>d", "<cmd>Telescope diagnostics<cr>", desc = "Show diagnostics" },
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>c", "<cmd>Telescope resume<cr>", desc = "Resume search" },
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>s", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>ss", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>sd", live_grep_in_directory, desc = "Live grep in directory" },
    { "<leader>sb", live_grep_in_open_buffers, desc = "Live grep in open buffers" },
    { "<leader>m", "<cmd>Telescope marks<cr>", desc = "Show marks" },
  },
}
