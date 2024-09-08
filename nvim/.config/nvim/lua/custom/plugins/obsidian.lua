return {
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      disable_frontmatter = true,
      workspaces = {
        {
          name = 'personal',
          path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/SimonsVault/',
        },
      },
      ui = {
        enable = false,
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  },
}
