return {
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "j-hui/fidget.nvim",
      {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          if type(opts.ensure_installed) == "table" and not vim.tbl_contains(opts.ensure_installed, "http") then
            table.insert(opts.ensure_installed, "http")
          end
        end,
      },
    },
    init = function()
      ---@type rest.Opts
      vim.g.rest_nvim = {
        request = {
          skip_ssl_verification = false,
          hooks = {
            encode_url = true,
          },
        },
        highlight = {
          enable = true,
        },
      }
    end,
  },
}
