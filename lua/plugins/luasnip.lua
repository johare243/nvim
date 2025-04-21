-- lua/plugins/luasnip.lua
return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    lazy = false,
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Optional: keymaps for snippet navigation if not using cmp
      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { silent = true, desc = "Expand or jump forward" })

      vim.keymap.set({ "i", "s" }, "<C-h>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true, desc = "Jump backward" })

      vim.keymap.set({ "i", "s" }, "<C-u>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end, { silent = true, desc = "Next choice" })
    end,
  },
}
