-- Dieses Modul richtet Rechtschreib-, Grammatik- und Stilprüfung für LaTeX in Neovim ein.

-- just a helper
local function read_dictionary_file(fname)
  local words = {}
  if vim.fn.filereadable(fname) == 1 then
    for line in io.lines(fname) do
      if line:match '%S' then
        table.insert(words, line)
      end
    end
  end
  return words
end

local M = {}

function M.setup()
  require('mason').setup()
  require('mason-lspconfig').setup { ensure_installed = { 'ltex' } }

  local spellfile = vim.fn.stdpath 'config' .. '/spell/de.utf-8.add'
  local vim_spell = read_dictionary_file(spellfile)

  require('lspconfig').ltex.setup {
    settings = {
      ltex = {
        language = 'de-DE',
        dictionary = { ['de-DE'] = vim_spell },
      },
    },
  }

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'tex',
    callback = function()
      vim.opt_local.spell = true
      vim.opt_local.spelllang = { 'de', 'en' }
    end,
  })

  -- 4) Stil-Linting via null-ls: proselint
  local null_ls = require 'null-ls'
  null_ls.setup {
    null_ls.builtins.diagnostics.proselint.with { args = { '--json', '$FILENAME' } },
    sources = {},
  }
end

return M
