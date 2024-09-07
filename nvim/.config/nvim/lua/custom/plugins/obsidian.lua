return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
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
}
