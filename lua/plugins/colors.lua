return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",    -- or "storm", "moon", "day"
    transparent = true, -- let terminal show through
    terminal_colors = true,
    styles = {
      sidebars = "transparent",
      floats   = "transparent",
    },
    -- Ensure ALL typical panes/floats respect transparency
    on_highlights = function(hl, c)
      hl.Normal          = { bg = "none" }
      hl.NormalNC        = { bg = "none" }
      hl.NormalFloat     = { bg = "none" }
      hl.FloatBorder     = { bg = "none" }
      hl.SignColumn      = { bg = "none" }
      hl.EndOfBuffer     = { bg = "none" }
      hl.LineNr          = { bg = "none" }
      hl.CursorLine      = { bg = "none" } -- comment this if you prefer a line highlight
      -- Common plugin UIs
      hl.TelescopeNormal = { bg = "none" }
      hl.TelescopeBorder = { bg = "none" }
      hl.Pmenu           = { bg = "none" }
      hl.PmenuSel        = { bg = c.blue, fg = c.bg } -- keep selection readable
      -- (Optional) file explorers/statuslines/etc:
      hl.NeotreeNormal   = { bg = "none" }
      hl.StatusLine      = { bg = "none" }
      hl.StatusLineNC    = { bg = "none" }
    end,
  },
  config = function(_, opts)
    vim.opt.termguicolors = true
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
