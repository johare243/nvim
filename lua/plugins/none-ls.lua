-- ~/.config/nvim/lua/plugins/none-ls.lua
return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")
    local utils = require("null-ls.utils")

    local APEX_FMT_GRP = vim.api.nvim_create_augroup("ApexFormat", { clear = true })

    null_ls.setup({
      root_dir = utils.root_pattern("package.json", "sfdx-project.json", ".git"),
      sources = {
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "apex", "apexcode" },
          prefer_local = "node_modules/.bin",
          extra_args = { "--plugin=prettier-plugin-apex" }, -- safe even with .prettierrc
        }),
      },
      on_attach = function(client, bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == "apex" or ft == "apexcode" then
          vim.api.nvim_clear_autocmds({ group = APEX_FMT_GRP, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = APEX_FMT_GRP,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                bufnr = bufnr,
                timeout_ms = 8000,
                filter = function(c) return c.name == "null-ls" end, -- <— forces null-ls
              })
            end,
            desc = "Format Apex on save via null-ls (prettier-plugin-apex)",
          })
        end
      end,
    })

    -- optional manual formatter
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({
        timeout_ms = 8000,
        filter = function(c) return c.name == "null-ls" end,
      })
    end, { desc = "Format with null-ls" })
  end,
}
