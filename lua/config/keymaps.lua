-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Restore default Vim 's' behavior (substitute character)
vim.keymap.del("n", "s")
vim.keymap.del("x", "s")
pcall(vim.keymap.del, { "n", "t" }, "<C-/>")
pcall(vim.keymap.del, { "n", "t" }, "<C-_>")
pcall(vim.keymap.del, "n", "<C-h>")
pcall(vim.keymap.del, "n", "<C-j>")
pcall(vim.keymap.del, "n", "<C-k>")
pcall(vim.keymap.del, "n", "<C-l>")
pcall(vim.keymap.del, "t", "<C-h>")
pcall(vim.keymap.del, "t", "<C-j>")
pcall(vim.keymap.del, "t", "<C-k>")
pcall(vim.keymap.del, "t", "<C-l>")

vim.keymap.set({ "n", "t" }, "<D-/>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })

vim.keymap.set("n", "<D-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<D-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<D-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<D-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
vim.keymap.set("t", "<D-h>", [[<C-\><C-n><C-w>h]], { desc = "Go to Left Window" })
vim.keymap.set("t", "<D-j>", [[<C-\><C-n><C-w>j]], { desc = "Go to Lower Window" })
vim.keymap.set("t", "<D-k>", [[<C-\><C-n><C-w>k]], { desc = "Go to Upper Window" })
vim.keymap.set("t", "<D-l>", [[<C-\><C-n><C-w>l]], { desc = "Go to Right Window" })

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

-- DATABASE
vim.keymap.set("n", "<leader>Dc", pick_db, { desc = "DB Pick Connection" })
vim.keymap.set("n", "<leader>Du", "<cmd>DBUIToggle<CR>", { desc = "DB UI" })

-- POSTMAN
vim.keymap.set("n", "<leader>pr", "<cmd>Rest run<cr>", { desc = "Run request" })
vim.keymap.set("n", "<leader>pa", "<cmd>Rest last<cr>", { desc = "Run last request" })
vim.keymap.set("n", "<leader>pl", "<cmd>Rest logs<cr>", { desc = "See last logs" })
