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
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ft = 'markdown',
    event = 'VeryLazy',
    opts = function()
      local colors = require('tokyonight.colors').setup()
      vim.api.nvim_set_hl(0, 'RMdH1', { fg = colors.red, bg = '' })
      vim.api.nvim_set_hl(0, 'RMdH2', { fg = colors.yellow, bg = '' })
      vim.api.nvim_set_hl(0, 'RMdH3', { fg = colors.green, bg = '' })
      vim.api.nvim_set_hl(0, 'RMdH4', { fg = colors.blue1, bg = '' })
      vim.api.nvim_set_hl(0, 'RMdH5', { fg = colors.teal, bg = '' })
      vim.api.nvim_set_hl(0, 'RMdH6', { fg = colors.purple, bg = '' })
      -- vim.api.nvim_set_hl(0, 'RMdCodeBlock', { bg = '#434343' })

      return {
        heading = {
          icons = { '✱ ', '✲ ', '✤ ', '✣ ', '✸ ', '✳ ' },
          backgrounds = {
            'RMdH1',
            'RMdH2',
            'RMdH3',
            'RMdH4',
            'RMdH5',
            'RMdH6',
          },
        },
        latex = {
          enabled = true,
          converter = 'latex2text',
          highlight = 'RenderMarkdownMath',
          top_pad = 0,
          bottom_pad = 1,
        },
        code = {
          sign = false,
          left_pad = 1,
          -- highlight = 'RMdCodeBlock',
        },
        quote = {
          icon = '┃',
        },
      }
    end,
  },
  { -- custom command to setup shell harpoon
    vim.api.nvim_create_user_command('SetupHarpoon', function()
      -- Get the current file path
      local filepath = vim.fn.expand '%:p'

      -- Define the output file path
      local output_file = vim.fn.expand '~/.shell_harpoon'

      -- Check if the file exists, and delete it if so
      if vim.fn.filereadable(output_file) == 1 then
        os.remove(output_file)
      end

      -- Create a new file and write the current filepath to it
      local file = io.open(output_file, 'w')
      if file then
        file:write(filepath)
        file:close()
        print('Current file path written to ' .. output_file)
      else
        print('Error: Could not open file ' .. output_file)
      end
    end, {}),
  },
}
