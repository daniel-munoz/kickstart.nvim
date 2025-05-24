-- Fix for LSP servers not initializing properly
-- Save this as lua/lsp_fix.lua and require it in your init.lua

local M = {}

function M.setup()
  -- Check if LSP is available
  local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
  if not has_lspconfig then
    vim.notify("nvim-lspconfig not available", vim.log.levels.ERROR)
    return
  end
  
  -- Enable debug logging
  vim.lsp.set_log_level("debug")
  
  -- Basic LSP server configs to ensure they're properly initialized
  -- Make sure these match the servers defined in your main config
  local servers = {
    gopls = {},
    lua_ls = {
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        }
      }
    },
    pyright = {},
  }
  
  -- Function to set up LSP keymaps on attach
  local on_attach = function(client, bufnr)
    vim.notify("LSP attached: " .. client.name, vim.log.levels.INFO)
    
    local function buf_set_keymap(mode, key, cmd, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, key, cmd, opts)
    end
    
    -- Core LSP keymaps
    buf_set_keymap('n', 'gd', vim.lsp.buf.definition, {desc = "LSP: Go to Definition"})
    buf_set_keymap('n', 'gD', vim.lsp.buf.declaration, {desc = "LSP: Go to Declaration"})
    buf_set_keymap('n', 'gi', vim.lsp.buf.implementation, {desc = "LSP: Go to Implementation"})
    buf_set_keymap('n', 'gr', vim.lsp.buf.references, {desc = "LSP: Go to References"}) 
    buf_set_keymap('n', 'K', vim.lsp.buf.hover, {desc = "LSP: Hover Documentation"})
  end
  
  -- Get default capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end
  
  -- Setup all servers
  for server_name, server_settings in pairs(servers) do
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = server_settings,
    }
  end
end

return M
