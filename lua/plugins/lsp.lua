return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "BufReadPost" },

    init = function()
      vim.filetype.add({ extension = { cls = "apex", trigger = "apex" } })
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.cls", "*.trigger", "*.apex", },
        callback = function()
          if vim.bo.filetype == "" then vim.bo.filetype = "apex" end
        end,
      })
    end,

    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim",
    },

    config = function()
      -- mason / fidget
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.lsp.handlers["textDocument/hover"] =
          vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
          vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
      require("mason").setup()
      require("mason-lspconfig").setup({ automatic_installation = true })
      require("fidget").setup({})

      --------------------------------------------------------------------------
      -- nvim-cmp + LuaSnip
      --------------------------------------------------------------------------
      local cmp = require("cmp")
      local cmp_lsp = require("cmp_nvim_lsp")
      local caps = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
      )

      -- load VSCode-format snippets
      pcall(function()
        require("luasnip.loaders.from_vscode").lazy_load({
          paths = { vim.fn.stdpath("config") .. "/snippets" },
        })
      end)


      cmp.setup({
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-y>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if not entry then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              end
              cmp.confirm()
            elseif require("luasnip").expand_or_locally_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s", "c" }),
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = { ghost_text = false },
      })

      -- cmdline completion
      cmp.setup.cmdline(":", {
        completion = { autocomplete = false },
        mapping = cmp.mapping.preset.cmdline({
          ["<C-n>"] = cmp.mapping.complete(),
          ["<C-y>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      --------------------------------------------------------------------------
      -- LSP Configuration (Simplified)
      --------------------------------------------------------------------------

      local function on_attach(client, bufnr)
        local o = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, o)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, o)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, o)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, o)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, o)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, o)
      end

      -- Find Apex JAR
      local function find_apex_jar()
        local candidates = {
          vim.fn.stdpath("data") .. "/mason/packages/apex-language-server/extension/dist/apex-jorje-lsp.jar",
          vim.fn.expand("$HOME/apex-jorje-lsp.jar"),
          vim.fn.expand("~/.vscode/extensions/salesforce.salesforcedx-vscode-apex-*/extension/dist/apex-jorje-lsp.jar"),
        }

        for _, path in ipairs(candidates) do
          if vim.fn.filereadable(path) == 1 then
            return path
          end
          -- Handle glob patterns
          local glob_result = vim.fn.glob(path, 1, 1)
          if type(glob_result) == "table" and #glob_result > 0 and vim.fn.filereadable(glob_result[#glob_result]) == 1 then
            return glob_result[#glob_result]
          end
        end
        return nil
      end

      local apex_jar = find_apex_jar()
      if not apex_jar then
        vim.notify("apex-jorje-lsp.jar not found. Install with :Mason → apex-language-server", vim.log.levels.ERROR)
      end

      -- lua_ls
      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        capabilities = caps,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } }
      })

      -- apex_ls
      vim.lsp.config("apex_ls", {
        cmd = apex_jar and { "java", "-jar", apex_jar } or nil,
        filetypes = { "apex", "apexcode", "soql", "sosl" },
        root_markers = { "sfdx-project.json", ".git" },
        single_file_support = true,
        on_attach = on_attach,
        capabilities = caps,
        settings = {
          apex = {
            java = { home = "/usr/lib/jvm/java-11-openjdk-amd64" },
            apex_enable_semantic_errors = false,
            apex_enable_completion_statistics = false,
          },
        },
      })

      -- Enable LSP servers
      vim.lsp.enable({ "lua_ls", "apex_ls", })
    end,
  },
}
