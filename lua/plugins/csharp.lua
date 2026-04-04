local csharp_ls_cmd = (vim.env.HOME or "") .. "/.dotnet/tools/csharp-ls"

local function has_executable(path)
  return path ~= "" and vim.fn.executable(path) == 1
end

return {
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      if not has_executable("dotnet") then
        opts.servers.fsautocomplete = nil
      end

      if not has_executable(csharp_ls_cmd) then
        opts.servers.csharp_ls = nil
        return
      end

      opts.servers.csharp_ls = {
        cmd = { csharp_ls_cmd },
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
      }
    end,
  },
}
