local rg = "/opt/homebrew/bin/rg"

if vim.uv.fs_stat(rg) then
  vim.opt.grepprg = rg .. " --vimgrep"
end

return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      if not vim.uv.fs_stat(rg) then
        return
      end

      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.grep = opts.picker.sources.grep or {}
      opts.picker.sources.grep.cmd = rg
      opts.picker.sources.grep_buffers = opts.picker.sources.grep_buffers or {}
      opts.picker.sources.grep_buffers.cmd = rg
      opts.picker.sources.grep_word = opts.picker.sources.grep_word or {}
      opts.picker.sources.grep_word.cmd = rg
    end,
  },
}
