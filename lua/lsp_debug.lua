local M = {}

-- Utility function to print active LSP clients
function M.print_active_clients()
  local clients = vim.lsp.get_active_clients()
  if #clients == 0 then
    print("No active LSP clients found")
    return
  end
  
  print("Active LSP clients:")
  for _, client in ipairs(clients) do
    print(string.format("- %s (id: %d, root: %s)", client.name, client.id, client.config.root_dir or "unknown"))
  end
end

-- Test LSP keymaps are defined for current buffer
function M.test_lsp_keymaps()
  local bufnr = vim.api.nvim_get_current_buf()
  local keymap_info = {}
  
  -- Common LSP keymaps to check
  local keymaps_to_check = {
    'gd', -- Go to definition
    'gI', -- Go to implementation 
    'gr', -- Go to references
    'gD', -- Go to declaration
    'K',  -- Hover documentation
  }
  
  local function check_keymap(mode, lhs)
    local maps = vim.api.nvim_buf_get_keymap(bufnr, mode)
    for _, map in ipairs(maps) do
      if map.lhs == lhs then
        return true, map.rhs or map.callback
      end
    end
    return false, nil
  end
  
  print("LSP Keymap Test Results for buffer " .. bufnr .. ":")
  
  -- Check if this buffer has an active LSP client
  local has_active_client = false
  for _, client in ipairs(vim.lsp.get_active_clients({bufnr = bufnr})) do
    has_active_client = true
    print("- LSP client attached: " .. client.name)
  end
  
  if not has_active_client then
    print("No LSP client attached to current buffer!")
  end
  
  -- Check keymaps
  for _, keymap in ipairs(keymaps_to_check) do
    local exists, target = check_keymap('n', keymap)
    if exists then
      print("✓ Keymap '" .. keymap .. "' is defined")
    else
      print("✗ Keymap '" .. keymap .. "' is NOT defined")
    end
  end
  
  -- Check file type
  local filetype = vim.bo[bufnr].filetype
  print("File type: " .. filetype)
  
  -- Show server capabilities
  for _, client in ipairs(vim.lsp.get_active_clients({bufnr = bufnr})) do
    print("Server capabilities for " .. client.name .. ":")
    local caps = {}
    if client.server_capabilities.definitionProvider then
      table.insert(caps, "definitionProvider")
    end
    if client.server_capabilities.implementationProvider then
      table.insert(caps, "implementationProvider") 
    end
    if client.server_capabilities.hoverProvider then
      table.insert(caps, "hoverProvider")
    end
    if client.server_capabilities.referencesProvider then
      table.insert(caps, "referencesProvider")
    end
    print("  - " .. table.concat(caps, ", "))
  end
end

return M
