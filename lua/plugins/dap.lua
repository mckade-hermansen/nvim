return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      local dap = require("dap")

      local netcoredbg = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg"

      dap.adapters.netcoredbg = {
        type = "executable",
        command = netcoredbg,
        args = { "--interpreter=vscode" },
        options = { detached = false },
      }
    end,
  },
}


