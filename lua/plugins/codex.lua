local function send_selection_to_codex()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  local source_win = vim.api.nvim_get_current_win()
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))

  local function send()
    if not vim.api.nvim_win_is_valid(source_win) then
      return
    end

    vim.api.nvim_win_call(source_win, function()
      require("codex.terminal_bridge").send_visual_reference({
        line1 = start_line,
        line2 = end_line,
      })
    end)
  end

  local term = require("codex.terminal")
  if term.get_active_terminal_bufnr() then
    send()
    return
  end

  require("codex").open()
  vim.defer_fn(send, 150)
end

return {
  {
    "pittcat/codex.nvim",
    name = "pittcat-codex.nvim",
    cmd = {
      "CodexToggle",
      "CodexOpen",
      "CodexSendSelection",
      "CodexSendReference",
      "CodexSendContent",
      "CodexSendPath",
    },
    keys = {
      {
        "<leader>ac",
        "<cmd>CodexToggle<cr>",
        desc = "Toggle Codex Chat",
        mode = "n",
      },
      {
        "<leader>ac",
        [[<C-\><C-n><cmd>CodexToggle<cr>]],
        desc = "Toggle Codex Chat",
        mode = "t",
      },
      {
        "<leader>as",
        send_selection_to_codex,
        desc = "Send Selection To Codex",
        mode = "v",
      },
    },
    opts = {
      terminal = {
        provider = "auto",
        direction = "vertical",
        size = 0.35,
        position = "right",
        auto_insert_mode = true,
      },
      terminal_bridge = {
        auto_attach = true,
        selection_mode = "reference",
      },
    },
  },
}
