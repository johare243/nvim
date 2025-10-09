return {
  "xixiaofinland/sf.nvim",
  lazy = false,

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "ibhagwan/fzf-lua",
    "stevearc/overseer.nvim",
  },

  config = function()
    require('sf').setup()

    local Sf = require('sf')
    vim.keymap.set('n', '<leader>zs', Sf.set_target_org, { desc = "Set Local Default Org" })
    vim.keymap.set('n', '<leader>zf', Sf.fetch_org_list, { desc = "Fetch Org List" })
    vim.keymap.set('n', '<leader>zS', Sf.set_global_target_org, { desc = "Set Global Default Org" })

    vim.keymap.set('n', '<leader>zp', Sf.save_and_push, { desc = "Save and Push" })
    vim.keymap.set('n', '<leader>zr', Sf.retrieve, { desc = "Retrieve File" })
    vim.keymap.set('n', '<leader>zo', Sf.open_test_select, { desc = "Open Test Select" })
    vim.keymap.set('n', '<leader>ztt', Sf.run_current_test, { desc = "Run Current Test" })
    vim.keymap.set('n', '<leader>ztl', Sf.repeat_last_tests, { desc = "Repeat Last Tests" })
    vim.keymap.set('n', '<leader>zta', Sf.run_all_tests_in_this_file, { desc = "Run All Tests File" })

    vim.keymap.set('n', '<leader>zct', Sf.create_ctags, { desc = "Create ctags File" })

    vim.keymap.set('n', '<leader>zq', Sf.run_highlighted_soql, { desc = "Run Highlighted SOQL" })
    vim.keymap.set('n', '<leader>z<leader>', Sf.toggle_term, { desc = "Toggle Salesforce Terminal" })
  end
}
