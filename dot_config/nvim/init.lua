vim.g.mapleader = " "

require("theme").setup()

function gh(repo)
  return "https://www.github.com/" .. repo
end
