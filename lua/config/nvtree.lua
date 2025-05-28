local M = {}

local api = require('nvim-tree.api')

-- local function opts(desc)
-- return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
-- end

local function my_on_attach(bufnr)
  api.config.mappings.default_on_attach(bufnr)
end

function M.setup()
  require("nvim-tree").setup({
    on_attach = my_on_attach,
  })
end
return M
