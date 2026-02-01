return {
  "stevearc/overseer.nvim",
  opts = {
    templates = { "builtin" },
    task_list = {
      direction = "bottom",
      bindings = {
        ["<C-l>"] = false,
        ["<C-h>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
      },
    },
  },
  keys = {
    { "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Run Task" },
    { "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Toggle Task List" },
    { "<leader>ra", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
  },
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    -- Register custom templates for your tasks
    overseer.register_template({
      name = "backend",
      builder = function()
        return {
          cmd = { "dotnet", "run" },
          cwd = vim.fn.getcwd() .. "/src/BioFire.FireWorks.Industry/",
          components = {
            { "on_output_quickfix", open = false },
            "default",
          },
        }
      end,
      desc = "Run .NET backend server",
      tags = { overseer.TAG.BUILD },
    })

    overseer.register_template({
      name = "frontend",
      builder = function()
        return {
          cmd = { "npm", "run", "dev:frontend" },
          cwd = vim.fn.getcwd() .. "/src/BioFire.FireWorks.Industry/ClientApp",
          components = {
            { "on_output_quickfix", open = false },
            "default",
          },
        }
      end,
      desc = "Run frontend dev server",
      tags = { overseer.TAG.BUILD },
    })

    overseer.register_template({
      name = "proxy",
      builder = function()
        return {
          cmd = { "npm", "run", "dev:proxy" },
          cwd = vim.fn.getcwd() .. "/src/BioFire.FireWorks.Industry/ClientApp",
          components = {
            { "on_output_quickfix", open = false },
            "default",
          },
        }
      end,
      desc = "Run proxy server",
      tags = { overseer.TAG.BUILD },
    })

    overseer.register_template({
      name = "run all",
      builder = function()
        return {
          cmd = { "echo", "Starting all services..." },
          components = {
            {
              "dependencies",
              task_names = {
                { "backend", sequential = false },
                { "proxy", sequential = false },
                { "frontend", sequential = false },
              },
            },
            "default",
          },
        }
      end,
      desc = "Run all services (backend, proxy, frontend)",
      tags = { overseer.TAG.BUILD },
    })
  end,
}
