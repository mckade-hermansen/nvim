local function find_flutter_bin()
  local home = vim.env.HOME
  local candidates = {
    vim.fn.exepath("flutter"),
    home .. "/flutter/bin/flutter",
    home .. "/development/flutter/bin/flutter",
    home .. "/dev/flutter/bin/flutter",
    home .. "/sdk/flutter/bin/flutter",
    home .. "/.local/flutter/bin/flutter",
    home .. "/.local/share/flutter/bin/flutter",
  }

  for _, candidate in ipairs(candidates) do
    if candidate ~= "" and vim.uv.fs_stat(candidate) then
      return vim.fn.resolve(candidate)
    end
  end
end

local function has_flutter()
  return find_flutter_bin() ~= nil
end

local function prepend_path(dir)
  if not dir or dir == "" or vim.fn.isdirectory(dir) == 0 then
    return
  end

  local path = vim.env.PATH or ""
  local parts = vim.split(path, ":", { plain = true, trimempty = true })
  if vim.tbl_contains(parts, dir) then
    return
  end

  vim.env.PATH = dir .. (path ~= "" and ":" .. path or "")
end

return {
  {
    "akinsho/flutter-tools.nvim",
    enabled = has_flutter,
    ft = { "dart" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
    },
    keys = {
      { "<leader>fr", "<cmd>FlutterRun<cr>", desc = "Flutter Run" },
      { "<leader>fq", "<cmd>FlutterQuit<cr>", desc = "Flutter Quit" },
      { "<leader>fR", "<cmd>FlutterRestart<cr>", desc = "Flutter Restart" },
      { "<leader>fd", "<cmd>FlutterDevices<cr>", desc = "Flutter Devices" },
      { "<leader>fm", "<cmd>FlutterEmulators<cr>", desc = "Flutter Emulators" },
      { "<leader>fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Flutter Outline" },
    },
    init = function()
      local flutter_bin = find_flutter_bin()
      if not flutter_bin then
        return
      end

      local flutter_bin_dir = vim.fs.dirname(flutter_bin)
      local dart_bin_dir = flutter_bin_dir .. "/cache/dart-sdk/bin"
      prepend_path(flutter_bin_dir)
      prepend_path(dart_bin_dir)
    end,
    opts = function()
      local flutter_bin = find_flutter_bin()
      return {
        fvm = true,
        flutter_path = flutter_bin,
        lsp = {
          color = {
            enabled = true,
            background = false,
          },
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            updateImportsOnRename = true,
          },
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
        },
        dev_log = {
          enabled = false,
        },
      }
    end,
    config = function(_, opts)
      require("flutter-tools").setup(opts)
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "dart-debug-adapter",
      })
    end,
  },
}
