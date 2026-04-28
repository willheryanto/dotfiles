return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSUninstall" },
	-- Allow lang files to extend ensure_installed
	opts_extend = { "ensure_installed" },
	-- Base parsers (vim-related)
	opts = {
		ensure_installed = {
			"vim",
			"vimdoc",
			"query",
			"regex",
			"bash",
		},
	},
	config = function(_, opts)
		local parsers = require("nvim-treesitter.parsers")
		local install = require("nvim-treesitter.install")

		if type(opts.ensure_installed) == "table" then
			local available = {}
			for lang, _ in pairs(parsers) do
				available[lang] = true
			end

			local to_install = {}
			for _, lang in ipairs(opts.ensure_installed) do
				if available[lang] then
					table.insert(to_install, lang)
				end
			end

			if #to_install > 0 then
				install.install(to_install)
			end
		end

		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})

		local ts_select = require("nvim-treesitter-textobjects.select")
		local ts_move = require("nvim-treesitter-textobjects.move")
		vim.keymap.set({ "x", "o" }, "ic", function()
			ts_select.select_textobject("@block.inner", "textobjects")
		end, { desc = "TS Textobject: inner block" })
		vim.keymap.set({ "x", "o" }, "ac", function()
			ts_select.select_textobject("@block.outer", "textobjects")
		end, { desc = "TS Textobject: outer block" })
		vim.keymap.set({ "x", "o" }, "if", function()
			ts_select.select_textobject("@function.inner", "textobjects")
		end, { desc = "TS Textobject: inner function" })
		vim.keymap.set({ "x", "o" }, "af", function()
			ts_select.select_textobject("@function.outer", "textobjects")
		end, { desc = "TS Textobject: outer function" })
		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			ts_move.goto_next_start("@function.outer", "textobjects")
		end, { desc = "TS Textobject: next function start" })
		vim.keymap.set({ "n", "x", "o" }, "]F", function()
			ts_move.goto_next_end("@function.outer", "textobjects")
		end, { desc = "TS Textobject: next function end" })
		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			ts_move.goto_previous_start("@function.outer", "textobjects")
		end, { desc = "TS Textobject: previous function start" })
		vim.keymap.set({ "n", "x", "o" }, "[F", function()
			ts_move.goto_previous_end("@function.outer", "textobjects")
		end, { desc = "TS Textobject: previous function end" })
		vim.keymap.set({ "n", "x", "o" }, "]c", function()
			ts_move.goto_next_start("@class.outer", "textobjects")
		end, { desc = "TS Textobject: next class start" })
		vim.keymap.set({ "n", "x", "o" }, "]C", function()
			ts_move.goto_next_end("@class.outer", "textobjects")
		end, { desc = "TS Textobject: next class end" })
		vim.keymap.set({ "n", "x", "o" }, "[c", function()
			ts_move.goto_previous_start("@class.outer", "textobjects")
		end, { desc = "TS Textobject: previous class start" })
		vim.keymap.set({ "n", "x", "o" }, "[C", function()
			ts_move.goto_previous_end("@class.outer", "textobjects")
		end, { desc = "TS Textobject: previous class end" })

		-- Enable treesitter highlighting for all filetypes
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
