return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    local cmp          = require('cmp')
    local cmp_lsp      = require("cmp_nvim_lsp")
    local luasnip      = require("luasnip")

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    -- on_attach with your keymaps
    local on_attach    = function(_, bufnr)
      local bufmap = function(lhs, fn, desc)
        vim.keymap.set('n', lhs, fn, { buffer = bufnr, desc = desc, silent = true, noremap = true })
      end

      bufmap('gd', vim.lsp.buf.definition, '[LSP] Go to definition')
      bufmap('gD', vim.lsp.buf.declaration, '[LSP] Go to declaration')
      bufmap('K', vim.lsp.buf.hover, '[LSP] Hover docs')
      bufmap('gi', vim.lsp.buf.implementation, '[LSP] Go to implementation')
      bufmap('gr', vim.lsp.buf.references, '[LSP] List references')
      bufmap('<leader>rn', vim.lsp.buf.rename, '[LSP] Rename symbol')
      bufmap('<leader>ca', vim.lsp.buf.code_action, '[LSP] Code action')
      bufmap('[d', vim.diagnostic.goto_prev, '[LSP] Prev diagnostic')
      bufmap(']d', vim.diagnostic.goto_next, '[LSP] Next diagnostic')
    end

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_enable = true,
      ensure_installed = { "lua_ls", "ts_ls", "pyright" },
      handlers = {
        -- default for all servers
        function(server_name)
          require("lspconfig")[server_name].setup {
            on_attach    = on_attach,
            capabilities = capabilities,
          }
        end,
        -- lua_ls with extra globals
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup {
            on_attach    = on_attach,
            capabilities = capabilities,
            settings     = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "describe", "it", "before_each", "after_each" },
                },
              },
            },
          }
        end,
        -- typescript via ts_ls
        ["ts_ls"] = function()
          local util = require("lspconfig.util")
          require("lspconfig").ts_ls.setup {
            on_attach    = on_attach,
            capabilities = capabilities,
            root_dir     = util.root_pattern("tsconfig.json", "jsconfig.json", ".git"),
          }
        end,
      },
    })

    -- nvim-cmp setup
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      preselect = cmp.PreselectMode.Item, -- always highlight first entry
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        -- navigate the completion menu with Ctrl-J/K
        ['<C-k>']     = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(cmp_select)
          else
            cmp.complete()
          end
        end, { 'i', 's' }),

        ['<C-j>']     = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item(cmp_select)
          else
            cmp.complete()
          end
        end, { 'i', 's' }),

        -- Tab: confirm the preselected item, else expand/jump snippet or fallback
        ['<Tab>']     = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- Shift-Tab: menu or snippet backward, else fallback
        ['<S-Tab>']   = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(cmp_select)
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- keep these if you like them
        ['<C-l>']     = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      }),
    })

    -- diagnostics styling
    vim.diagnostic.config({
      virtual_text     = { prefix = "●", spacing = 4 },
      signs            = true,
      underline        = true,
      update_in_insert = false,
      float            = {
        focusable = false,
        style     = "minimal",
        border    = "rounded",
        source    = "if_many",
        header    = "",
        prefix    = "",
      },
    })
  end,
}
