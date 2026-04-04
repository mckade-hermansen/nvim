local function dartls_config(bufname)
  local util = require("lspconfig.util")

  return {
    name = "dartls",
    cmd = { "dart", "language-server", "--protocol=lsp" },
    root_dir = util.root_pattern("pubspec.yaml", ".git")(bufname) or util.path.dirname(bufname),
    init_options = {
      onlyAnalyzeProjectsWithOpenFiles = true,
      suggestFromUnimportedLibraries = true,
      closingLabels = true,
      outline = true,
      flutterOutline = true,
    },
    settings = {
      dart = {
        completeFunctionCalls = true,
        showTodos = true,
      },
    },
  }
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dartls = {
          cmd = { "dart", "language-server", "--protocol=lsp" },
          filetypes = { "dart" },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("pubspec.yaml", ".git")(fname) or util.path.dirname(fname)
          end,
          single_file_support = true,
          init_options = {
            onlyAnalyzeProjectsWithOpenFiles = true,
            suggestFromUnimportedLibraries = true,
            closingLabels = true,
            outline = true,
            flutterOutline = true,
          },
          settings = {
            dart = {
              completeFunctionCalls = true,
              showTodos = true,
            },
          },
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dart",
        callback = function(args)
          if vim.fn.executable("dart") ~= 1 then
            return
          end

          if #vim.lsp.get_clients({ bufnr = args.buf, name = "dartls" }) > 0 then
            return
          end

          local bufname = vim.api.nvim_buf_get_name(args.buf)
          if bufname == "" then
            return
          end

          vim.lsp.start(dartls_config(bufname), {
            bufnr = args.buf,
            silent = true,
          })
        end,
      })
    end,
  },
}
