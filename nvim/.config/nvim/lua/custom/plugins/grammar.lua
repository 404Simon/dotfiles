-- Datei: ~/.config/nvim/lua/grammar.lua

-- Dieses Modul richtet Rechtschreib-, Grammatik- und Stilprüfung für LaTeX in Neovim ein.
local M = {}

function M.setup()
  -- 1) LTeX-LS installieren über Mason
  require('mason').setup()
  require('mason-lspconfig').setup { ensure_installed = { 'ltex' } }

  -- 2) LTeX per lspconfig
  require('lspconfig').ltex.setup {
    settings = {
      ltex = {
        language = 'de-DE',
        dictionary = { ['de-DE'] = { 'Fachbegriff' } },
      },
    },
  }

  -- 3) native Rechtschreibprüfung für .tex aktivieren
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'tex',
    callback = function()
      vim.opt_local.spell = true
      vim.opt_local.spelllang = { 'de', 'en' }
    end,
  })

  -- 4) Stil-Linting via null-ls: proselint & Vale
  local null_ls = require 'null-ls'
  null_ls.setup {
    null_ls.builtins.diagnostics.proselint.with { args = { '--json', '$FILENAME' } },
    sources = {},
  }
end

return M
