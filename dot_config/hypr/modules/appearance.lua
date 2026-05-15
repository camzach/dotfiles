local colors = require("modules.colors")

local function strip_hash(c)
	return c:gsub("^#", "")
end

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,
		border_size = 2,
		col = {
			active_border = {
				colors = {
					"rgba(" .. strip_hash(colors.primary) .. "ff)",
					"rgba(" .. strip_hash(colors.tertiary) .. "ff)",
				},
				angle = 45,
			},
			inactive_border = "rgba(" .. strip_hash(colors.surface.container) .. "aa)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(" .. strip_hash(colors.background) .. "ee)",
		},
	},

	animations = {
		enabled = false,
	},

	dwindle = {
		preserve_split = true,
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = 0,
		accel_profile = "flat",
	},
})
