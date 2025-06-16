return {
  'NvChad/nvterm',
  config = function()
    require('nvterm').setup {
      terminals = {
        type_ops = {
          horizontal = { location = 'rightbelow', split_ratio = 0.3 },
          vertical = { location = 'rightbelow', split_ratio = 0.5 },
        },
      },
    }
  end,
}
