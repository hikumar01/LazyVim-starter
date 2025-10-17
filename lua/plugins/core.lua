-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- Configure LazyVim to load vim colorscheme (similar to vim default but better)
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vim",
    },
  },

  -- change trouble config
--   HK
--   {
--     "folke/trouble.nvim",
--     -- opts will be merged with the parent spec
--     opts = { use_diagnostic_signs = true },
--   },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        -- clangd for C/C++ support
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders=true",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
--   HK
--   { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "c",
        "cpp",
        "cmake",
        "make",
        "objc",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "objective-c",
        "objective-cpp",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "c",
        "cpp",
        "cmake",
        "make",
        "objc",
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- Ensure we don't interfere with search functionality
      opts.options = opts.options or {}
      opts.options.globalstatus = true

      -- Add custom status component that doesn't interfere with search
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    --   HK
    --   table.insert(opts.sections.lualine_x, {
    --     function()
    --       -- Only show status when not in search mode or command mode
    --       local mode = vim.fn.mode()
    --       if mode == "c" or vim.g.search_mode or vim.fn.getcmdtype() ~= "" then
    --         return "" -- Don't show anything during search or command mode
    --       end

    --       -- Show diagnostics if there are issues
    --       local diagnostics = vim.diagnostic.get(0)
    --       local errors = #vim.tbl_filter(function(d)
    --         return d.severity == 1
    --       end, diagnostics)
    --       local warnings = #vim.tbl_filter(function(d)
    --         return d.severity == 2
    --       end, diagnostics)

    --       if errors > 0 then
    --         return "󰅚 " .. errors
    --       end
    --       if warnings > 0 then
    --         return "󰀪 " .. warnings
    --       end

    --       -- Show git status if in a repo
    --       local git_status = vim.b.gitsigns_status_dict
    --       if git_status then
    --         local added = git_status.added or 0
    --         local changed = git_status.changed or 0
    --         local removed = git_status.removed or 0

    --         if added > 0 then
    --           return "+" .. added
    --         end
    --         if changed > 0 then
    --           return "~" .. changed
    --         end
    --         if removed > 0 then
    --           return "-" .. removed
    --         end
    --       end

    --       -- Show LSP status
    --       local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    --       if #clients > 0 then
    --         return "󰄭"
    --       end

    --       -- Default
    --       return "󰄬"
    --     end,
    --     cond = function()
    --       -- Only show when not in command mode, search, or during command input
    --       local mode = vim.fn.mode()
    --       return mode ~= "c" and not vim.g.search_mode and vim.fn.getcmdtype() == ""
    --     end,
    --   })
    end,
  },

  -- use mini.starter instead of alpha
--   HK -- to avoid conflict with snacks dashboard
--   { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
--   HK
--   { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        -- C/C++ tools
        "clangd",
        "clang-format",
        "codelldb", -- debugger
        "cpptools", -- additional C++ tools
      },
    },
  },

  -- Floating terminal at bottom
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "float",
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
  },

  -- Better command line with scrollable suggestions
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}
