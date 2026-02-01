return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
      },
      formatters = {
        prettier = {
          -- Ensure prettier uses the project's config files
          prepend_args = { "--config-precedence", "file-override" },
        },
      },
    },
  },
}
