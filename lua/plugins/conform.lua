return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
      formatters_by_ft = {
        -- web / ts
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        jsonc = { "prettier" },
        css = { "prettierd", "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        -- prisma
        prisma = { "prettier" },
        -- python
        python = { "ruff_format", "black" },
        -- lua
        lua = { "stylua" },
        -- sh
        sh = { "shfmt" },
      },
    },
  },
}

