return {
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        csharp_ls = {
          cmd = { os.getenv("HOME") .. "/.dotnet/tools/csharp-ls" },
          filetypes = { "cs" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("*.sln", "*.csproj", ".git")(fname)
          end,
          init_options = {
            AutomaticWorkspaceInit = true,
          },
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          keys = {
            {
              "gd",
              function()
                require("omnisharp_extended").lsp_definitions()
              end,
              desc = "Goto Definition",
            },
          },
        },
      },
    },
  },
}
