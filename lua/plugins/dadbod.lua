return {
  -- Core DB client
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection" },
  },

  -- UI explorer
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = true
    end,
  },

  -- SQL completion
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql" },
  },
}
