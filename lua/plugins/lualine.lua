-- lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = function()
    return {
      options = {
        theme                = "auto",
        icons_enabled        = true,
        globalstatus         = true,
        component_separators = { left = "│", right = "│" },
        section_separators   = { left = "", right = "" },
        disabled_filetypes   = {
          statusline = { "alpha", "dashboard", "starter", "neo-tree", "lazy" },
          winbar = {},
        },
        refresh              = { statusline = 200, tabline = 200, winbar = 200 },
      },

      sections = {
        lualine_a = { { "mode", separator = { left = "", right = "" }, padding = { left = 1, right = 1 } } },
        lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
        lualine_c = {
          "filename", {
          "require'sf'.get_target_org()",
          path = 1,
          newfile_status = true,
          symbols = {
            modified = "●",
            readonly = "",
            unnamed = "[No Name]",
            newfile = "[New]"
          },
          shorting_target = 40
        },
        },
        lualine_x = { { "encoding" }, { "fileformat" }, { "filetype" } },
        lualine_y = { "progress" },
        lualine_z = { { "location", separator = { left = "", right = "" }, padding = { left = 1, right = 1 } } },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },

      tabline = {},
      extensions = { "quickfix", "man", "lazy", "mason", "neo-tree", "toggleterm", "trouble" },
    }
  end,
}
