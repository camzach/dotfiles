return {
  "echasnovski/mini.pick",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.extra",
  },
  config = function()
    local pick = require("mini.pick")
    local extra = require("mini.extra")

    pick.setup({})

    local function grep_picker()
      local process
      local set_items_opts = { do_match = false }
      ---@diagnostic disable-next-line: undefined-field
      local spawn_opts = { cwd = vim.uv.cwd() }

      local match = function(_, _, query)
        -- Kill previous process
        ---@diagnostic disable-next-line: undefined-field
        pcall(vim.loop.process_kill, process)

        -- For empty query, explicitly set empty items to indicate "not working"
        if #query == 0 then
          return MiniPick.set_picker_items({}, set_items_opts)
        end

        -- Get the full query string
        local full_query = table.concat(query)
        -- Split on symbol
        local search_pattern, file_pattern =
          ---@diagnostic disable-next-line: deprecated
          unpack(vim.split(full_query, "::", { plain = true }))

        -- Build command
        local command = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        }

        -- Add search pattern
        if search_pattern and search_pattern ~= "" then
          table.insert(command, "-e")
          table.insert(command, search_pattern)
        end

        -- Add file/dir pattern if provided
        if file_pattern and file_pattern ~= "" then
          table.insert(command, "-g")
          table.insert(command, file_pattern)
        end

        process = MiniPick.set_picker_items_from_cli(command, {
          postprocess = function(lines)
            local results = {}
            for _, line in ipairs(lines) do
              if line ~= "" then
                -- I had nightmare doing this line, I hope there will be a better way
                local file, lnum, col, text = line:match("([^:]+):(%d+):(%d+):(.*)")
                if file then
                  -- Format the item in a way that default_choose can handle - yay
                  results[#results + 1] = {
                    path = file,
                    lnum = tonumber(lnum),
                    col = tonumber(col),
                    text = line,
                  }
                end
              end
            end
            return results
          end,
          set_items_opts = set_items_opts,
          spawn_opts = spawn_opts,
        })
      end

      return pick.start({
        source = {
          items = {},
          name = "Multi Grep",
          match = match,
          show = function(buf_id, items_to_show, query)
            pick.default_show(buf_id, items_to_show, query, { show_icons = true })
          end,
          choose = pick.default_choose,
        },
      })
    end

    vim.keymap.set("n", "<leader>d", extra.pickers.diagnostic, { desc = "Show diagnostics" })
    vim.keymap.set("n", "<leader>f", pick.builtin.files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>c", pick.registry.resume, { desc = "Resume search" })
    vim.keymap.set("n", "<leader>b", pick.builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>s", grep_picker, { desc = "Grep" })
    vim.keymap.set("n", "<leader>m", extra.pickers.marks, { desc = "Show marks" })
  end,
}
