local colors = require('config.theme').colors

local theme = {
	normal = {
		a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
		b = { fg = colors.fg, bg = colors.bg_alt },
		c = { fg = colors.fg, bg = colors.bg },
	},
	insert = {
		a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
	},
	visual = {
		a = { fg = colors.bg, bg = colors.purple, gui = 'bold' },
	},
	replace = {
		a = { fg = colors.bg, bg = colors.red, gui = 'bold' },
	},
	command = {
		a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' },
	},
	inactive = {
		a = { fg = colors.fg, bg = colors.bg_alt },
		b = { fg = colors.fg, bg = colors.bg_alt },
		c = { fg = colors.fg, bg = colors.bg },
	},
}

return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = { theme = theme },
		sections = {
			lualine_c = { { "filename", path = 1 } },
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
