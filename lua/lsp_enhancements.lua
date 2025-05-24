-- Enhanced LSP configuration for fixing keybinding issues
-- Place this file in ~/.config/nvim/lua/lsp_enhancements.lua

local M = {}

-- Function to fix LSP keymaps and ensure servers are properly attached
function M.setup()
  -- Check if LSP is available
  local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
  if not has_lspconfig then
    vim.notify("nvim-lspconfig not available", vim.log.levels.ERROR)
    return
  end
  
  -- Get default capabilities with cmp support if available
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end
  
  -- Enhanced on_attach function with extra debug info
  local on_attach = function(client, bufnr)
    vim.notify("LSP '" .. client.name .. "' attached to buffer " .. bufnr, vim.log.levels.INFO)
    
    -- Set up buffer-local keymaps
    local function nmap(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end
      
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end
    
    -- Core LSP functionality keymaps
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<M-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    
    -- Additional LSP features
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    
    -- Workspace functions
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')
    
    -- Telescope integration if available
    local has_telescope, builtin = pcall(require, 'telescope.builtin')
    if has_telescope then
      nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    end
    
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
  end
  
  -- Configure LSP servers (similar to your existing config)
  local servers = {
    gopls = {
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    },
    pyright = {},
  }
  
  -- Setup Mason integration if available
  local has_mason, _ = pcall(require, 'mason')
  local has_mason_lspconfig, mason_lspconfig = pcall(require, 'mason-lspconfig')
  
  -- Configure Mason if available
  if has_mason and has_mason_lspconfig then
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }
  end
  
  -- Setup all servers with direct configuration
  for server_name, server_settings in pairs(servers) do
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = server_settings,
    }
  end
  
  -- Provide feedback
  vim.notify("LSP keymaps configured successfully", vim.log.levels.INFO)
end

return M
