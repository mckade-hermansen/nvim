return {
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
        },
      },
    },
  },
}
