return {
  "LazyVim/LazyVim",
  priority = 10000, -- load early
  init = function()
    local unpack = unpack or table.unpack


    -- Patch vim.keymap.set
    local orig_set = vim.keymap.set
    vim.keymap.set = function(mode, lhs, rhs, opts)
      if vim.in_fast_event() then
        local args = { mode, lhs, rhs, opts }
        return vim.schedule(function()
          orig_set(unpack(args))
        end)
      end
      return orig_set(mode, lhs, rhs, opts)
    end

    -- Patch direct API calls too (some plugins use this)
    local orig_api_set = vim.api.nvim_set_keymap
    vim.api.nvim_set_keymap = function(mode, lhs, rhs, opts)
      if vim.in_fast_event() then
        local args = { mode, lhs, rhs, opts }
        return vim.schedule(function()
          orig_api_set(unpack(args))
        end)
      end
      return orig_api_set(mode, lhs, rhs, opts)
    end
  end,
}

