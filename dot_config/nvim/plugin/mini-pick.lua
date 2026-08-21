vim.pack.add({
  "https://www.github.com/echasnovski/mini.pick",
  "https://www.github.com/echasnovski/mini.extra",
})

local pick = require("mini.pick")
local extra = require("mini.extra")

pick.setup({})

local function grep_picker()
  local process
  local query_id = 0
  local set_items_opts = { do_match = false }
  local spawn_opts = { cwd = vim.uv.cwd() }

  local match = function(_, _, query)
    -- Kill previous process before starting new one
    if process then
      pcall(vim.uv.process_kill, process, "sigterm")
    end
    
    -- Increment query ID to track the latest query
    query_id = query_id + 1
    local current_query_id = query_id

    -- For empty query, explicitly set empty items to indicate "not working"
    if #query == 0 then
      return MiniPick.set_picker_items({}, set_items_opts)
    end

    -- Get the full query string
    local full_query = table.concat(query)
    -- Split on ::
    local parts = vim.split(full_query, "::", { plain = true })
    local search_pattern = parts[1]
    local file_pattern = parts[2]

    -- Build base ripgrep command
    local rg_cmd = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    }

    -- Add file pattern as glob if provided
    if file_pattern and file_pattern ~= "" then
      table.insert(rg_cmd, "--glob")
      table.insert(rg_cmd, "*" .. file_pattern .. "*")
    end

    -- Add search pattern
    if search_pattern and search_pattern ~= "" then
      table.insert(rg_cmd, "-e")
      table.insert(rg_cmd, search_pattern)
    end

    process = MiniPick.set_picker_items_from_cli(rg_cmd, {
      postprocess = function(lines)
        -- Ignore results from stale queries
        if current_query_id ~= query_id then
          return {}
        end
        
        local results = {}
        for _, line in ipairs(lines) do
          if line ~= "" then
            local file, lnum, col, text = line:match("([^:]+):(%d+):(%d+):(.*)")
            if file then
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

local function files_no_ignore()
  local command = { "rg", "--files", "--no-ignore", "--hidden" }
  return pick.start({
    source = {
      name = "All Files (including ignored)",
      items = vim.fn.systemlist(command),
      show = function(buf_id, items_to_show, query)
        pick.default_show(buf_id, items_to_show, query, { show_icons = true })
      end,
      choose = pick.default_choose,
    },
  })
end

vim.keymap.set("n", "<leader>d", extra.pickers.diagnostic, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>f", pick.builtin.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>F", files_no_ignore, { desc = "Find all files (no ignore)" })
vim.keymap.set("n", "<leader>c", pick.registry.resume, { desc = "Resume search" })
vim.keymap.set("n", "<leader>b", pick.builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>s", grep_picker, { desc = "Grep" })
vim.keymap.set("n", "<leader>m", extra.pickers.marks, { desc = "Show marks" })
