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
    { "<leader>ri", "<cmd>IosSimulator<cr>", desc = "Start iOS Simulator" },
  },
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    vim.api.nvim_create_user_command("IosSimulator", function()
      overseer.run_task({ name = "ios simulator", autostart = true }, function(_, err)
        if err then
          vim.notify(err, vim.log.levels.ERROR)
        end
      end)
    end, { desc = "Start the iOS Simulator" })

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
      name = "run flutter app iphone air",
      builder = function()
        return {
          cmd = {
            "flutter", "run", "-d", "1D911001-F00D-427A-8468-28E10D507682"
          },
          components = { "default" },
        }
      end,
      tags = { overseer.TAG.BUILD },
    })

    overseer.register_template({
      name = "ios simulator",
      builder = function()
        return {
          cmd = {
            "sh",
            "-lc",
            [[xcrun simctl boot "iPhone Air" >/dev/null 2>&1 || true
xcrun simctl bootstatus "iPhone Air" -b
open -a Simulator]],
          },
          components = { "default" },
        }
      end,
      desc = "Start the iOS Simulator app",
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
