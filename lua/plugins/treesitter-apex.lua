return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    for _, lang in ipairs({ "apex", "soql", "sosl", "sflog" }) do
      parser_config[lang] = {
        install_info = {
          url = "https://github.com/aheber/tree-sitter-sfapex",
          files = { lang .. "/src/parser.c" },
        },
        filetype = lang,
      }
    end
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, { "apex", "soql", "sosl", "sflog" })
    return opts
  end,
}
