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

local homebrew_bin = "/opt/homebrew/bin"
local function prefer_homebrew_bin()
  if not vim.uv.fs_stat(homebrew_bin) then
    return
  end

  local path = vim.fn.getenv("PATH")
  local parts = vim.split(path or "", ":", { plain = true, trimempty = true })
  local filtered = {}
  for _, part in ipairs(parts) do
    if part ~= homebrew_bin then
      table.insert(filtered, part)
    end
  end

  local new_path = table.concat(vim.list_extend({ homebrew_bin }, filtered), ":")
  vim.env.PATH = new_path
  vim.fn.setenv("PATH", new_path)
end

prefer_homebrew_bin()

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = prefer_homebrew_bin,
})
