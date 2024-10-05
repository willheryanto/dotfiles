-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Tokyo Night Moon"
-- config.color_scheme = "Catppuccin Mocha"
config.colors = {
	foreground = "#f9f6ee",
	background = "#090a04",
	cursor_bg = "#c1c1c1",
	cursor_fg = "#090a04",
	selection_fg = "#f9f6ee",
	selection_bg = "#3c3836",
	ansi = {
		"#1d2021",
		"#ff3131",
		"#98971a",
		"#d79921",
		"#458588",
		"#b16286",
		"#689d6a",
		"#a89984",
	},
	brights = {
		"#928374",
		"#fb4934",
		"#b8bb26",
		"#fabd2f",
		"#83a598",
		"#d3869b",
		"#8ec07c",
		"#ebdbb2",
	},
}

config.font = wezterm.font("MonoLisa")
config.font_size = 13.0
config.line_height = 1.2
config.cell_width = 1.0
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
