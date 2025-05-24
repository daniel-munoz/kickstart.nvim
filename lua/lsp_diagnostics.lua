-- Simple Neovim plugin for LSP diagnostics and testing
-- Place this file in ~/.config/nvim/lua/lsp_diagnostics.lua

local M = {}

-- Get LSP client status for all buffers
function M.status()
  local buffers = vim.api.nvim_list_bufs()
  local active_buffers = {}

  -- Filter only loaded buffers
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) then
      table.insert(active_buffers, buf)
    end
  end

  -- Print header
  print("=== LSP Client Status ===")
  print(string.format("%d active buffer(s):", #active_buffers))
  
  -- Check LSP clients for each buffer
  for _, buf in ipairs(active_buffers) do
    local filename = vim.api.nvim_buf_get_name(buf)
    local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
    
    print("\nBuffer " .. buf .. ": " .. (filename ~= "" and filename or "[No Name]") .. " (" .. filetype .. ")")
    
    local clients = vim.lsp.get_active_clients({ bufnr = buf })
    if #clients == 0 then
      print("  No LSP clients attached")
    else
      print("  LSP clients attached:")
      for _, client in ipairs(clients) do
        print("  - " .. client.name)
      end
      
      -- Check keymaps for this buffer
      print("  Keymaps for this buffer:")
      local keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
      local lsp_keymaps_count = 0
      
      for _, keymap in ipairs(keymaps) do
        if keymap.desc and keymap.desc:match("^LSP:") then
          print("  - " .. keymap.lhs .. " → " .. keymap.desc)
          lsp_keymaps_count = lsp_keymaps_count + 1
        end
      end
      
      if lsp_keymaps_count == 0 then
        print("  No LSP-specific keymaps found")
      end
    end
  end
end

-- Function to test LSP functionality for current buffer
function M.test_current_buffer()
  local buf = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(buf)
  local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
  
  print("\n=== LSP Test for Current Buffer ===")
  print("Buffer: " .. buf)
  print("Filename: " .. (filename ~= "" and filename or "[No Name]"))
  print("Filetype: " .. filetype)
  
  -- Check if LSP clients are attached
  local clients = vim.lsp.get_active_clients({ bufnr = buf })
  if #clients == 0 then
    print("\nNo LSP clients attached to this buffer")
    print("Possible reasons:")
    print("- LSP server not installed")
    print("- No LSP server configured for filetype: " .. filetype)
    print("- LSP server failed to start")
    
    -- Suggest fix
    print("\nTry running this command to fix:")
    print(":lua require('lsp_enhancements').setup()")
    return
  end
  
  -- Show attached clients
  print("\nLSP clients attached:")
  for _, client in ipairs(clients) do
    print("- " .. client.name .. " (id: " .. client.id .. ")")
    
    -- Show some capabilities
    print("  Capabilities:")
    if client.server_capabilities.hoverProvider then
      print("  ✓ Hover (K)")
    else
      print("  ✗ Hover not supported")
    end
    
    if client.server_capabilities.definitionProvider then
      print("  ✓ Go to Definition (gd)")
    else
      print("  ✗ Definition not supported")
    end
    
    if client.server_capabilities.implementationProvider then
      print("  ✓ Go to Implementation (gI)")
    else
      print("  ✗ Implementation not supported")
    end
  end
  
  -- Check keymaps
  print("\nLSP Keymaps for this buffer:")
  local keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
  local lsp_keymaps_count = 0
  
  for _, keymap in ipairs(keymaps) do
    if keymap.desc and keymap.desc:match("^LSP:") then
      print("✓ " .. keymap.lhs .. " → " .. keymap.desc)
      lsp_keymaps_count = lsp_keymaps_count + 1
    end
  end
  
  if lsp_keymaps_count == 0 then
    print("No LSP-specific keymaps found!")
    print("Try running: :lua require('lsp_enhancements').setup()")
  else
    print("\nKeymaps are configured. Try using:")
    print("- K over symbol for hover documentation")
    print("- gd on symbol to go to definition")
    print("- gI on symbol to go to implementation")
  end
end

-- Add commands to Neovim
function M.setup_commands()
  vim.api.nvim_create_user_command("LspStatus", function()
    M.status()
  end, { desc = "Show LSP status for all buffers" })
  
  vim.api.nvim_create_user_command("LspTest", function()
    M.test_current_buffer()
  end, { desc = "Test LSP functionality for current buffer" })
  
  vim.api.nvim_create_user_command("LspFix", function()
    require('lsp_enhancements').setup()
  end, { desc = "Fix LSP setup and keymaps" })
  
  -- Create keymaps
  vim.keymap.set('n', '<leader>ls', ':LspStatus<CR>', { desc = 'Show LSP Status' })
  vim.keymap.set('n', '<leader>lt', ':LspTest<CR>', { desc = 'Test LSP in current buffer' })
  vim.keymap.set('n', '<leader>lf', ':LspFix<CR>', { desc = 'Fix LSP setup' })
end

return M
