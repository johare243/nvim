return {
	"xixiaofinland/sf.nvim",
	lazy = false,

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"ibhagwan/fzf-lua",
		"stevearc/overseer.nvim",
	},

	config = function()
		require("sf").setup()

		local Sf = require("sf")

		--Anon execution
		vim.keymap.set("n", "<leader>zz", ":SF currentFile RunAsAnonymous<cr>", { desc = "Open Default Org" })

		--target org
		vim.keymap.set("n", "<leader>zo", ":SF org open<cr>", { desc = "Open Default Org" })
		vim.keymap.set("n", "<leader>zf", Sf.fetch_org_list, { desc = "Fetch Org List" })
		vim.keymap.set("n", "<leader>zt", Sf.set_target_org, { desc = "Set Local Default Org" })
		vim.keymap.set("n", "<leader>zT", Sf.set_global_target_org, { desc = "Set Global Default Org" })

		-- file commands
		vim.keymap.set("n", "<leader>zp", Sf.save_and_push, { desc = "Save and Push" })
		vim.keymap.set("n", "<leader>zr", Sf.retrieve, { desc = "Retrieve File" })
		vim.keymap.set("n", "<leader>zt", Sf.run_current_test, { desc = "Run Current Test" })
		vim.keymap.set("n", "<leader>zl", Sf.repeat_last_tests, { desc = "Repeat Last Tests" })
		vim.keymap.set("n", "<leader>za", Sf.run_all_tests_in_this_file, { desc = "Run All Tests File" })

		-- create
		vim.keymap.set("n", "<leader>zca", ":SF create apex<cr>", { desc = "Save and Push" })
		vim.keymap.set("n", "<leader>zct", ":SF create trigger<cr>", { desc = "Save and Push" })
		vim.keymap.set("n", "<leader>zcl", ":SF create lwc<cr>", { desc = "Save and Push" })
		vim.keymap.set("n", "<leader>zca", ":SF create aura<cr>", { desc = "Save and Push" })
		vim.keymap.set("n", "<leader>zcc", Sf.create_ctags, { desc = "Create ctags File" })

		vim.keymap.set("n", "<leader>zh", Sf.run_highlighted_soql, { desc = "Run Highlighted SOQL" })
		vim.keymap.set("v", "<leader>zh", Sf.run_highlighted_soql, { desc = "Run Highlighted SOQL" })
		vim.keymap.set("n", "<leader>z<leader>", Sf.toggle_term, { desc = "Toggle Salesforce Terminal" })
	end,
}
