# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a customized Neovim configuration based on kickstart.nvim - a minimal, educational starting point for Neovim configurations. It's designed as a foundation for learning and customization rather than a complete distribution.

## Core Architecture

- **Single-file configuration**: `init.lua` contains the main configuration (~1000 lines)
- **Plugin system**: Uses Lazy.nvim for plugin management with lazy loading
- **Custom plugins**: Located in `lua/custom/plugins/` for personal additions
- **Kickstart plugins**: Original configurations in `lua/kickstart/`
- **Plugin lockfile**: `lazy-lock.json` tracks plugin versions

## Environment-Based Features

This configuration uses environment variables to conditionally enable features:

- `PROJECT_CONTEXT=personal` - Enables Claude Code integration
- `NVIM_COPILOT=true` - Enables GitHub Copilot features  
- `NVIM_AVANTE=true` - Enables Avante AI assistant

## Key Components

### AI Assistant Integration
- **Claude Code**: Integrated via `claude-code.nvim` plugin (environment-gated)
- **GitHub Copilot**: Full integration with chat capabilities
- **Avante**: Multi-provider AI assistant supporting Claude, OpenAI, Copilot, and Gemini

### Language Support
- **LSP**: Configured with `nvim-lspconfig` and Mason for automatic server installation
- **Completion**: Uses `blink.cmp` for autocompletion
- **Formatting**: Handled by `conform.nvim`

### Navigation & Search
- **Telescope**: Primary fuzzy finder with fzf-native backend
- **File explorer**: NvimTree with custom keymaps (`<M-1>`, `<M-2>`)
- **Code outline**: Aerial.nvim for symbol navigation (`<M-3>`, `<M-4>`)
- **Search/Replace**: CtrlSF for advanced search operations

## Development Workflow

This is a configuration project without traditional build/test commands. Development involves:

1. **Editing configuration**: Modify `init.lua` or add plugins in `lua/custom/plugins/`
2. **Testing changes**: Restart Neovim or use `:Lazy reload` for plugins
3. **Plugin management**: Use `:Lazy` interface to install/update/remove plugins
4. **Lockfile**: `lazy-lock.json` ensures reproducible plugin versions

## Important Keybindings

- **AI Assistants**: `<leader>cc` (Copilot Chat), `<leader>Cc` (Claude Code)
- **File Navigation**: `<M-1>` (File tree), `<M-3>` (Code outline)  
- **Terminal**: `<leader>tt` (horizontal), `<leader>tf` (floating)
- **Search**: `<leader>sf` (files), `<leader>sg` (grep), `<leader>fa` (find all)
- **LSP**: `gd` (definition), `gr` (references), `<leader>rn` (rename)

## Configuration Philosophy

- **Educational first**: Extensive comments and documentation
- **Performance optimized**: Lazy loading and conditional features
- **Beginner friendly**: Clear keymaps and help integration
- **Fork-and-modify**: Designed to be customized rather than used as-is
