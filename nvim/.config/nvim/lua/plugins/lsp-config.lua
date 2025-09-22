return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    lazy = false,
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities()
      )

      local servers = {
        "tailwindcss",
        "lua_ls",
        "clangd",
        "gopls",
        "jsonls",
        "marksman",
        "phpactor",
        "pyright",
        "stimulus_ls",
        "stylua",
      }

      for _, lsp in ipairs(servers) do
        vim.lsp.config(lsp, {
          capabilities = capabilities,
        })
      end

      require('mason-tool-installer').setup({ ensure_installed = servers })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
    end,
  },
}
