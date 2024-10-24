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

-- config.colors = {
-- 	background = "#1c1c1c",
-- 	foreground = "#c0c0c0",
-- 	cursor_bg = "#c1c1c1",
-- 	cursor_fg = "#090a04",
-- 	cursor_border = "#bdfe58",
-- 	selection_fg = "#c0c0c0",
-- 	selection_bg = "#303030",
-- 	scrollbar_thumb = "#404040",
--
-- 	-- Map of ANSI color codes to theme colors
-- 	ansi = {
-- 		"#1c1c1c",
-- 		"#ff3131",
-- 		"#98971a",
-- 		"#d79921",
-- 		"#458588",
-- 		"#b16286",
-- 		"#1bfd9c",
-- 		"#c0c0c0",
-- 	},
-- 	brights = {
-- 		"#585858",
-- 		"#fb4934",
-- 		"#b8bb26",
-- 		"#fabd2f",
-- 		"#83a598",
-- 		"#d3869b",
-- 		"#8ec07c",
-- 		"#ebdbb2",
-- 	},
--
-- 	-- Additional elements you might want to color
-- 	visual_bell = "#404040",
-- 	tab_bar = {
-- 		background = "#1c1c1c",
-- 		active_tab = {
-- 			bg_color = "#303030", -- visual selection color
-- 			fg_color = "#c0c0c0",
-- 		},
-- 		inactive_tab = {
-- 			bg_color = "#1c1c1c",
-- 			fg_color = "#585858",
-- 		},
-- 		inactive_tab_hover = {
-- 			bg_color = "#303030",
-- 			fg_color = "#c0c0c0",
-- 		},
-- 	},
-- }

config.keys = {
	-- { key = "Tab", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	-- { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment }
}

config.font = wezterm.font({ 
  family = "MonoLisa" ,
  harfbuzz_features = {
    "frac", -- fractions
    "onum", -- old style numbers
    "liga", -- coding ligatures
    "calt", -- whitespace ligatures
    "zero", -- slashed zero
    "ss01", -- normal asterisk
    "ss02", -- script variant
    -- "ss03", -- alt g
    -- "ss04", -- alt g
    -- "ss05", -- alt sharp s
    "ss06", -- alt at
    "ss07", -- alt curly bracket
    "ss08", -- alt parenthesis
    -- "ss09", -- alt greater equal
    "ss10", -- allt greater equal
    "ss11", -- hexadecimal x
    "ss12", -- thin backslash
    "ss13", -- alt dollar
    -- "ss14", -- alt &
    "ss15", -- i without serif
    "ss16", -- r without serif
    "ss17", -- alt .= and ..=
    "ss18" -- alt at
  },
})

config.font_size = 14.0
config.line_height = 1.0
config.cell_width = 1.0
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
