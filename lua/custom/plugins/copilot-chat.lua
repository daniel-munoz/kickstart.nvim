return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- Shared config starts here (can be passed to functions at runtime and configured via setup function)

      system_prompt = 'COPILOT_INSTRUCTIONS', -- System prompt to use (can be specified manually in prompt via /).

      model = 'gpt-4.1', -- Default model to use, see ':CopilotChatModels' for available models (can be specified manually in prompt via $).
      agent = 'copilot', -- Default agent to use, see ':CopilotChatAgents' for available agents (can be specified manually in prompt via @).
      context = nil, -- Default context or array of contexts to use (can be specified manually in prompt via #).
      sticky = nil, -- Default sticky prompt or array of sticky prompts to use at start of every new chat.

      temperature = 0.1, -- GPT result temperature
      headless = false, -- Do not write to chat buffer and use history (useful for using custom processing)
      stream = nil, -- Function called when receiving stream updates (returned string is appended to the chat buffer)
      callback = nil, -- Function called when full response is received (retuned string is stored to history)
      remember_as_sticky = true, -- Remember model/agent/context as sticky prompts when asking questions

      -- see select.lua for implementation
      selection = visual,

      -- default window options
      window = {
        layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace', or a function that returns the layout
        width = 0.4, -- fractional width of parent, or absolute width in columns when > 1
        height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
        -- Options below only apply to floating windows
        relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
        border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        row = nil, -- row position of the window, default is centered
        col = nil, -- column position of the window, default is centered
        title = 'Copilot Chat', -- title of chat window
        footer = nil, -- footer of chat window
        zindex = 1, -- determines if window is on top or below other floating windows
      },

      show_help = true, -- Shows help message as virtual lines when waiting for user input
      highlight_selection = true, -- Highlight selection
      highlight_headers = true, -- Highlight headers in chat, disable if using markdown renderers (like render-markdown.nvim)
      references_display = 'virtual', -- 'virtual', 'write', Display references in chat as virtual text or write to buffer
      auto_follow_cursor = true, -- Auto-follow cursor in chat
      auto_insert_mode = false, -- Automatically enter insert mode when opening window and on new prompt
      insert_at_end = false, -- Move cursor to end of buffer when inserting text
      clear_chat_on_new_prompt = false, -- Clears chat on every new prompt

      -- Static config starts here (can be configured only via setup function)

      debug = false, -- Enable debug logging (same as 'log_level = 'debug')
      log_level = 'info', -- Log level to use, 'trace', 'debug', 'info', 'warn', 'error', 'fatal'
      proxy = nil, -- [protocol://]host[:port] Use this proxy
      allow_insecure = false, -- Allow insecure server connections

      chat_autocomplete = true, -- Enable chat autocompletion (when disabled, requires manual `mappings.complete` trigger)

      log_path = vim.fn.stdpath 'state' .. '/CopilotChat.log', -- Default path to log file
      history_path = vim.fn.stdpath 'data' .. '/copilotchat_history', -- Default path to stored history

      question_header = '# User ', -- Header to use for user questions
      answer_header = '# Copilot ', -- Header to use for AI answers
      error_header = '# Error ', -- Header to use for errors
      separator = '───', -- Separator to use in chat

      -- default providers
      -- see config/providers.lua for implementation
      providers = {
        copilot = {},
        github_models = {},
        copilot_embeddings = {},
      },

      -- default contexts
      -- see config/contexts.lua for implementation
      contexts = {
        buffer = {},
        buffers = {},
        file = {},
        files = {},
        git = {},
        url = {},
        register = {},
        quickfix = {},
        system = {},
      },

      -- default prompts
      -- see config/prompts.lua for implementation
      prompts = {
        Explain = {
          prompt = 'Write an explanation for the selected code as paragraphs of text.',
          system_prompt = 'COPILOT_EXPLAIN',
        },
        Review = {
          prompt = 'Review the selected code.',
          system_prompt = 'COPILOT_REVIEW',
        },
        Fix = {
          prompt = 'There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems.',
        },
        Optimize = {
          prompt = 'Optimize the selected code to improve performance and readability. Explain your optimization strategy and the benefits of your changes.',
        },
        Refactor = {
          prompt = 'Please refactor the following code to improve its clarity and readability.',
        },
        Docs = {
          prompt = 'Please add documentation comments to the selected code.',
        },
        Tests = {
          prompt = 'Please generate tests for my code.',
        },
        Commit = {
          prompt = 'Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.',
          context = 'git:staged',
        },
      },

      -- default mappings
      -- see config/mappings.lua for implementation
      mappings = {
        complete = {
          insert = '<Tab>',
        },
        close = {
          normal = 'q',
          insert = '<C-c>',
        },
        reset = {
          normal = '<C-l>',
          insert = '<C-l>',
        },
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-s>',
        },
        toggle_sticky = {
          normal = 'grr',
        },
        clear_stickies = {
          normal = 'grx',
        },
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
        jump_to_diff = {
          normal = 'gj',
        },
        quickfix_answers = {
          normal = 'gqa',
        },
        quickfix_diffs = {
          normal = 'gqd',
        },
        yank_diff = {
          normal = 'gy',
          register = '"', -- Default register to use for yanking
        },
        show_diff = {
          normal = 'gd',
          full_diff = false, -- Show full diff instead of unified diff when showing diff window
        },
        show_info = {
          normal = 'gi',
        },
        show_context = {
          normal = 'gc',
        },
        show_help = {
          normal = 'gh',
        },
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}

--[[
      debug = false,
      auto_start = false,
      window = {
        border = "rounded",
        width = 80,
        height = 20,
      },
      mappings = {
        close = "<Esc>",
        submit = "<CR>",
        next_message = "<Tab>",
        prev_message = "<S-Tab>",
        yank_last = { "n", "<leader>cy" },
        -- Keymap to open the prompt selection
        select_prompt = { "n", "<leader>cp" },
      },
      prompts = {
        Explain = {
          prompt = "Explain the following code: %s",
          description = "Explain selected code", -- Optional description for the picker
        },
        Tests = {
          prompt = "Write unit tests for the following code, using the prevalent testing framework: %s",
          description = "Generate unit tests",
        },
        Refactor = {
          prompt = "Refactor the following code to improve readability and maintainability: %s",
          description = "Refactor selected code",
        },
        Docstring = {
          prompt = "Generate a comprehensive docstring for the following code: %s",
          description = "Generate docstring",
        },
        FixBugs = {
          prompt = "Identify and fix potential bugs in the following code: %s",
          description = "Fix bugs in selected code",
        },
        CustomAgent = { -- You can name them whatever you like
          prompt = "You are a helpful assistant specialized in Lua. Answer the following question about Lua: %s",
          description = "Ask a Lua expert",
          -- You might be able to specify if it should take selection or be a general prompt
          -- selection = false, -- (This depends on plugin implementation)
        },
        CustomAgent = { -- You can name them whatever you like
          prompt = "You are a helpful assistant specialized in Golang. Answer the following question about Go: %s",
          description = "Ask a Go expert",
          -- You might be able to specify if it should take selection or be a general prompt
          -- selection = false, -- (This depends on plugin implementation)
        }
      },
      -- model = "gpt-4", -- Uncomment if you want to specify a model
      -- history_path = vim.fn.stdpath("data") .. "/copilot-chat-history.json",
--]]
