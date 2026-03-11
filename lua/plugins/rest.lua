return {
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = false,
        result_split_in_place = false,
        skip_ssl_verification = false,
        encode_url = true,
        highlight = { enabled = true },
      })
    end,
  },
}

