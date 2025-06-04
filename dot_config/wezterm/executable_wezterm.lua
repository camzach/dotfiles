-- Initialize Configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local opacity = 1
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"

--- Get the current operating system
-- @return "windows"| "linux" | "macos"
local function get_os()
	if wezterm.target_triple:match("windows") then
		return "windows"
	end
	if wezterm.target_triple:match("darwin") then
		return "macos"
	end
	if wezterm.target_triple:match("linux") then
		return "linux"
	end
	return "unknown"
end

local host_os = get_os()

-- Font Configuration
local emoji_font = "Noto Color Emoji"
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMono Nerd Font",
		weight = "Regular",
	},
	emoji_font
})
config.font_size = 10

-- Color Configuration
config.colors = require("cyberdream")
config.force_reverse_video_cursor = true

-- Window Configuration
config.initial_rows = 45
config.initial_cols = 180
config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = opacity
config.window_background_image = (os.getenv("WEZTERM_CONFIG_FILE") or ""):gsub("wezterm.lua", "bg-blurred.png")
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"

-- Performance Settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
config.colors.tab_bar = {
	background = transparent_bg,
	new_tab = { fg_color = config.colors.background, bg_color = config.colors.brights[6] },
	new_tab_hover = { fg_color = config.colors.background, bg_color = config.colors.foreground },
}

-- Tab Formatting
wezterm.on("format-tab-title", function(tab, _, _, _, hover)
	local background = config.colors.brights[1]
	local foreground = config.colors.foreground

	if tab.is_active then
		background = config.colors.brights[7]
		foreground = config.colors.background
	elseif hover then
		background = config.colors.brights[8]
		foreground = config.colors.background
	end

	local title = tostring(tab.tab_index + 1)
	return {
		{ Foreground = { Color = background } },
		{ Text = "█" },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Foreground = { Color = background } },
		{ Text = "█" },
	}
end)

-- Keybindings
config.keys = {
	{ key = "l", mods = "ALT",            action = wezterm.action.ShowLauncher },
	{ key = "j", mods = "CTRL|ALT|SHIFT", action = wezterm.action.PaneSelect },
	{ key = "s", mods = "CTRL|ALT|SHIFT", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },
}

if os.getenv("XDG_CURRENT_DESKTOP") == "Hyprland" then
	config.enable_wayland = false
else
	config.enable_wayland = true
end

-- OS-Specific Overrides
if host_os == "windows" then
	local wsl_domains = wezterm.default_wsl_domains()
	for _, dom in ipairs(wsl_domains) do
		dom.default_cwd = "~"
	end
	config.wsl_domains = wsl_domains
	config.default_domain = "WSL:Ubuntu"
end

return config
