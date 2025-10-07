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
    vim.keymap.set('n', '<leader>ss', Sf.set_target_org, { desc = "Set Local Default Org" })
    vim.keymap.set('n', '<leader>sS', Sf.set_global_target_org, { desc = "Set Global Default Org" })
    vim.keymap.set('n', '<leader>sct', Sf.create_ctags, { desc = "Create ctags File" })
    vim.keymap.set('n', '<leader>sfp', Sf.save_and_push, { desc = "Save and Push" })
    vim.keymap.set('n', '<leader>sfr', Sf.retrieve, { desc = "Retrieve File" })
    vim.keymap.set('n', '<leader>so', Sf.open_test_select, { desc = "Open Test Select" })
    vim.keymap.set('n', '<leader>stt', Sf.run_current_test, { desc = "Run Current Test" })
    vim.keymap.set('n', '<leader>sta', Sf.run_all_tests_in_this_file, { desc = "Run All Tests File" })
    vim.keymap.set('n', '<leader>s<leader>', Sf.toggle_term, { desc = "Toggle Salesforce Terminal" })
  end
}
