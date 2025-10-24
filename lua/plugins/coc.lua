return {
  "neoclide/coc.nvim",
  branch = "release",
  build = "npm ci --silent",
  init = function()
    -- runtime opts Coc benefits from
    local vim = vim
    vim.o.updatetime = 300
    vim.o.signcolumn = "yes"
    vim.o.shortmess = vim.o.shortmess .. "c"

    -- Always load coc-apex and treat ft=apex as apexcode (for CoC only)
    vim.g.coc_global_extensions = {
      "coc-apex",
      -- add more if you want:
       "coc-tsserver", "coc-json", "coc-prettier", "coc-yaml", "coc-html", "coc-css", "coc-sh", "coc-pyright"
    }
    vim.g.coc_filetype_map = { apex = 'apexcode' } -- <— legacy global that applies very early


    vim.g.coc_user_config = {
      ["coc.preferences.filetypeMap"] = { apex = "apexcode" },
      ["suggest.autoTrigger"] = "always",
      ["suggest.minTriggerInputLength"] = 1,
      ["suggest.noselect"] = false,
      ["diagnostic.enable"] = true,
      ["diagnostic.virtualText"] = true,
      ["diagnostic.virtualTextCurrentLineOnly"] = false,
      ["diagnostic.virtualTextPrefix"] = "● ",
    }

    -- Ensure proper Vim filetypes for syntax, while CoC sees apexcode via filetypeMap
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*.cls", "*.trigger", "*.apex" },
      callback = function() vim.bo.filetype = "apex" end,
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "apexcode",
      callback = function()
        vim.bo.filetype = "apex"
        vim.cmd("doautocmd <nomodeline> FileType apex")
      end,
    })
  end,
  config = function()
    -- Insert-mode completion keys
    local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
    vim.keymap.set("i", "<Tab>", [[coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()]],
      opts)
    vim.keymap.set("i", "<S-Tab>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
    vim.keymap.set("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], opts)
    -- Optional manual trigger
    vim.keymap.set("i", "<C-Space>", "coc#refresh()", opts)

    -- Backspace helper
    vim.cmd([[
      function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1] =~# '\s'
      endfunction
    ]])

    -- LSP-like nav/actions
    vim.keymap.set("n", "gd", "<Plug>(coc-definition)")
    vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)")
    vim.keymap.set("n", "gi", "<Plug>(coc-implementation)")
    vim.keymap.set("n", "gr", "<Plug>(coc-references)")
    vim.keymap.set("n", "K", ":call CocActionAsync('doHover')<CR>", { silent = true })
    vim.keymap.set("n", "[d", "<Plug>(coc-diagnostic-prev)")
    vim.keymap.set("n", "]d", "<Plug>(coc-diagnostic-next)")
    vim.keymap.set({ "n", "x" }, "<leader>a", "<Plug>(coc-codeaction)")
    vim.keymap.set({ "n", "x" }, "<leader>f", "<Plug>(coc-format-selected)")
    vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)")
    vim.keymap.set("n", "<leader>dl", ":CocList diagnostics<CR>", { silent = true, noremap = true })

    -- Format on save (async; remove if undesired)
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function() pcall(vim.fn.CocActionAsync, "format") end,
    })

    -- Signature help on snippet jumps (optional)
    vim.api.nvim_create_autocmd("User", {
      pattern = "CocJumpPlaceholder",
      callback = function() pcall(vim.fn.CocActionAsync, "showSignatureHelp") end,
    })

    -- Gutter signs (optional)
    vim.g.coc_status_error_sign = ""
    vim.g.coc_status_warning_sign = ""
    vim.g.coc_status_info_sign = ""
  end,
}
