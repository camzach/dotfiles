local colors = require('config.theme').colors

local theme = {
	normal = {
		a = { fg = colors.bg, bg = colors.primary, gui = 'bold' },
		b = { fg = colors.fg, bg = colors.bg_alt },
		c = { fg = colors.fg, bg = colors.bg },
	},
	insert = {
		a = { fg = colors.bg, bg = colors.success, gui = 'bold' },
	},
	visual = {
		a = { fg = colors.bg, bg = colors.tertiary, gui = 'bold' },
	},
	replace = {
		a = { fg = colors.bg, bg = colors.error, gui = 'bold' },
	},
	command = {
		a = { fg = colors.bg, bg = colors.warning, gui = 'bold' },
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
