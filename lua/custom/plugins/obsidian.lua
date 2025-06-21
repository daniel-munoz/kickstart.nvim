return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  --  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    'BufReadPre '
      .. vim.fn.expand '~'
      .. '/Dropbox/Personal/Notes/ObsidianVault/Main/*.md',
    'BufNewFile ' .. vim.fn.expand '~' .. '/Dropbox/Personal/Notes/ObsidianVault/Main/*.md',
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = 'Main',
        path = '/Users/danielm/Dropbox/Personal/Notes/ObsidianVault/Main',
      },
      {
        name = 'Momo',
        path = '/Users/danielm/Dropbox/Personal/Notes/ObsidianVault/Momo',
      },
      {
        name = 'Work',
        path = '/Users/danielm/Dropbox/Personal/Notes/ObsidianVault/Work',
      },
    },
    -- see below for full list of options 👇
  },
}
