local M = {
  'github/copilot.vim',
  lazy = true,
  event = 'InsertEnter',
}
function M.config()
  -- assume no default <Tab> mapping
  vim.g.copilot_no_tab_map = true
  vim.g.copilot_assume_mapped = true

  -- insert-mode accept
  vim.keymap.set('i', '<C-h>', 'copilot#Accept("<CR>")',
    { expr = true, silent = true, replace_keycodes = false })

  -- toggle state
  local copilot_on = true

  -- :CopilotToggle command
  vim.api.nvim_create_user_command('CopilotToggle', function()
    if copilot_on then
      vim.cmd('Copilot disable')
      print('Copilot OFF')
    else
      vim.cmd('Copilot enable')
      print('Copilot ON')
    end
    copilot_on = not copilot_on
  end, {})

  -- normal-mode toggle mapping
  vim.keymap.set('n', '<C-0>', '<Cmd>CopilotToggle<CR>',
    { noremap = true, silent = true })
end

M.config = M.config
return M
