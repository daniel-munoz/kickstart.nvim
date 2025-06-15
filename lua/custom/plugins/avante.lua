return {
  'yetone/avante.nvim',
  enabled = vim.fn.getenv 'NVIM_AVANTE' == 'true',
  event = { 'BufReadPost', 'CmdlineEnter' }, -- More specific events for better lazy-loading
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = 'copilot', -- Default provider

    -- Model configurations
    providers = {
      claude = {
        -- endpoint = 'https://api.anthropic.com', -- Ensure this is configured if needed
        model = 'claude-3-7-sonnet-latest',
        extra_request_body = {
          temperature = 0, -- 0 for deterministic responses
          max_tokens = 32768, -- Optimized token limit (reduced from 64k)
          timeout = 60000, -- 60 second timeout (increased from 30s)
        },
      },

      openai = {
        endpoint = 'https://api.openai.com/v1',
        model = 'codex-mini-latest',
        extra_request_body = {
          temperature = 0, -- 0 for deterministic responses
          max_completion_tokens = 100000,
          timeout = 45000, -- 45 second timeout (adjusted from 30s)
        },
      },

      copilot = {
        model = 'gemini-2.5-pro',
        debounce_ms = 200, -- Add debounce for potentially better performance
        suggestion_auto_trigger = true, -- Enable auto-triggering if supported
      },

      gemini = {
        endpoint = 'https://generativelanguage.googleapis.com/v1beta',
        api_key_name = 'GEMINI_API_KEY', -- Instructs Avante to use vim.fn.getenv('GEMINI_API_KEY')
        model = 'gemini-2.5-flash-preview-05-20',
        extra_request_body = {
          temperature = 0, -- 0 for deterministic responses
          max_output_tokens = 65536, -- Max tokens for Gemini models, can be adjusted
          timeout = 60000, -- 60 seconds timeout
        },
      },
    },

    -- UI configurations
    ui = {
      max_lines = 15, -- Limit UI height for popups
      border = 'rounded', -- Consistent UI style
    },

    -- Performance optimizations
    cache = {
      enabled = true, -- Enable caching of responses
      ttl = 3600, -- Cache Time-To-Live in seconds (1 hour)
    },
  },

  build = 'make', -- Default build command
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows

  -- Organized dependencies by functionality
  dependencies = {
    -- Core dependencies
    { 'nvim-treesitter/nvim-treesitter', lazy = true },
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',

    -- File selector providers (lazy-loaded examples, adjust cmd if needed)
    { 'echasnovski/mini.pick', lazy = true }, -- cmd = "AvanteMiniPick"
    { 'nvim-telescope/telescope.nvim', lazy = true }, -- cmd = "AvanteTelescope"
    { 'ibhagwan/fzf-lua', lazy = true }, -- cmd = "AvanteFzfLua"

    -- UI enhancements
    'nvim-tree/nvim-web-devicons', -- For icons
    { 'hrsh7th/nvim-cmp', event = 'InsertEnter' }, -- Load on insert for autocompletion

    -- Provider integrations
    { 'zbirenbaum/copilot.lua', lazy = true }, -- For provider = 'copilot' (GitHub Copilot)

    -- Image pasting
    {
      'HakonHarnes/img-clip.nvim',
      event = 'BufReadPost', -- Load when entering insert mode, or map to a command/key
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
          use_absolute_path = true,
          path = vim.fn.stdpath 'cache' .. '/img-clip', -- Store images in a dedicated cache subdir
          relative_to_current_file = true, -- Manage paths relative to the current file
          max_dimensions = { width = 1024, height = 1024 }, -- Resize large images
        },
      },
    },

    -- Markdown rendering
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
        highlight = true, -- Enable syntax highlighting in rendered markdown
        code_block = {
          theme = 'github-dark', -- Consistent theme for code blocks (or your preferred)
          padding = 1, -- Add padding for better readability
        },
      },
      ft = { 'markdown', 'Avante' }, -- Load on specified filetypes
    },
  },

  -- Optional: Performance config for disabling unused core Neovim plugins
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}
