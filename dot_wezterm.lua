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

-- config.window_background_opacity = 0.60
config.color_scheme = "Night Owl (Gogh)"

config.keys = {
	-- { key = "Tab", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	-- { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment }
}

config.max_fps = 120

config.font = wezterm.font({
	family = "MonoLisa",
	harfbuzz_features = {
		-- "frac", -- fractions
		-- "onum", -- old style numbers
		"liga", -- coding ligatures
		"calt", -- whitespace ligatures
		"zero", -- slashed zero
		"ss01", -- normal asterisk
		"ss02", -- script variant
		-- "ss03", -- alt g
		-- "ss04", -- alt g
		-- "ss05", -- alt sharp s
		-- "ss06", -- alt at
		"ss07", -- alt curly bracket
		"ss08", -- alt parenthesis
		-- "ss09", -- alt greater equal
		"ss10", -- allt greater equal
		"ss11", -- hexadecimal x
		"ss12", -- thin backslash
		"ss13", -- alt dollar
		"ss14", -- alt &
		"ss15", -- i without serif
		"ss16", -- r without serif
		"ss17", -- alt .= and ..=
		"ss18", -- alt at @
	},
})

config.font_size = 14.0
config.line_height = 1.0
config.cell_width = 1.0
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
