-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Restore default Vim 's' behavior (substitute character)
vim.keymap.del("n", "s")
vim.keymap.del("x", "s")

local function pick_db()
  local dbs = vim.g.dbs or {}
  local nameToUrl = {}
  local names = {}
  for name, url in pairs(dbs) do
    if url and url ~= "" then
	nameToUrl[name] = url
	table.insert(names, name)
    end
  end
  table.sort(names)

  vim.ui.select(names, { prompt = "Select DB connection" }, function(choice)
    if not choice then return end
    -- Set active connection for the current session/buffer usage
    vim.g.db = nameToUrl[choice]
    vim.notify("Active DB: " .. choice)
  end)
end

vim.keymap.set("n", "<leader>Dc", pick_db, { desc = "DB Pick Connection" })
vim.keymap.set("n", "<leader>Du", "<cmd>DBUIToggle<CR>", { desc = "DB UI" })

