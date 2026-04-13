-- Oil: Edit filesystem like a buffer
return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"-",
			function()
				require("oil").open_float()
			end,
			desc = "Open parent directory (float)",
		},
		{
			"<leader>e",
			function()
				require("oil").open_float()
			end,
			desc = "Explorer (Oil)",
		},
	},
	opts = {
		default_file_explorer = true,
		columns = {
			"icon",
		},
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-w>v"] = { "actions.select", opts = { vertical = true, close = true } },
			["<C-w>s"] = { "actions.select", opts = { horizontal = true, close = true } },
			["<C-w>T"] = { "actions.select", opts = { tab = true, close = true } },
			["gp"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["q"] = "actions.close",
			["<Esc>"] = "actions.close",
			["gr"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = { "actions.cd", opts = { scope = "tab" } },
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
		},
		use_default_keymaps = false,
		win_options = {
			winbar = "%{v:lua.require('oil').get_current_dir()}",
		},
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name)
				return name == ".." or name == ".git"
			end,
		},
		float = {
			padding = 2,
			max_width = 120,
			max_height = 35,
			border = "rounded",
			win_options = {
				winbar = "%{v:lua.require('oil').get_current_dir()}",
			},
		},
	},
}
