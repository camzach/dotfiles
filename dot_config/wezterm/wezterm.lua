-- Initialize Configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()

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

--- Get background image path with error handling
local function get_background_image()
	local config_file = os.getenv("WEZTERM_CONFIG_FILE")
	if config_file then
		local bg_path = config_file:gsub("wezterm.lua", "bg-blurred.png")
		local f = io.open(bg_path, "r")
		if f then
			f:close()
			return bg_path
		end
	end
	return nil
end

-- Font Configuration
local emoji_font = "Noto Color Emoji"
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMono Nerd Font",
		weight = "Regular",
	},
	emoji_font,
})
config.font_size = host_os == "macos" and 12 or 10

-- Color Configuration
config.colors = require("colors")
config.force_reverse_video_cursor = true

-- Window Configuration
config.initial_rows = 45
config.initial_cols = 180
config.window_decorations = "TITLE | RESIZE"
config.window_background_image = get_background_image()
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"
config.adjust_window_size_when_changing_font_size = false

-- Performance Settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Scrollback and Links
config.scrollback_lines = 10000
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
config.colors.tab_bar = {
	background = config.colors.background,
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

-- Leader Key Configuration (like tmux)
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- Keybindings
config.keys = {
	-- Disable ALT+Enter to allow it to pass through to nvim
	{ key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },

	-- Navigate panes: CTRL+A then h/j/k/l
	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },

	-- Split panes: CTRL+A then - or |
	{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "|", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Close pane: CTRL+A then x
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	-- Resize panes: CTRL+A then H/J/K/L (shift held)
	{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
	{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },

	-- Swap panes: CTRL+A then s
	{ key = "s", mods = "LEADER", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },

	-- Launcher: CTRL+A then Space
	{ key = "Space", mods = "LEADER", action = wezterm.action.ShowLauncher },

	-- Send CTRL+A to terminal (for tools that use it): CTRL+A then a
	{ key = "a", mods = "LEADER|CTRL", action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }) },
}

-- Wayland Configuration (Linux only)
if host_os == "linux" then
	local desktop = os.getenv("XDG_CURRENT_DESKTOP")
	config.enable_wayland = desktop ~= "Hyprland"
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
