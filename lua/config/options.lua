-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable format on save
vim.g.autoformat = false

-- Set tab width to 4 spaces for all languages
vim.opt.tabstop = 4        -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4     -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4    -- Number of spaces that a <Tab> counts for while editing
vim.opt.expandtab = true   -- Use spaces instead of tabs

vim.g.root_spec = {
  "lsp",
  { ".git", "lua", "package.json", "*.sln" },
  "cwd",
}

vim.g.dbs = {
    dev_fw = os.getenv("DEV_FW"),
    dev_global = os.getenv("DEV_GLOBAL"),
    dev_dw = os.getenv("DEV_DW"),
    dev_regional = os.getenv("DEV_REGIONAL"),
}
