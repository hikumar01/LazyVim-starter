-- ============================================================================
-- SYNTAX HIGHLIGHTING & APPEARANCE
-- ============================================================================
vim.cmd('syntax on') -- Enable syntax highlighting
vim.cmd('filetype on') -- Enable filetype detection
vim.opt.termguicolors = true -- Enable 24-bit RGB colors

-- ============================================================================
-- LINE NUMBERS & NAVIGATION
-- ============================================================================
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.wrap = false -- Don't wrap lines
vim.opt.scrolloff = 4 -- Keep 4 lines above/below cursor
vim.opt.sidescrolloff = 4 -- Keep 4 columns left/right of cursor

-- ============================================================================
-- SEARCH OPTIONS
-- ============================================================================
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Show search matches as you type
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Case sensitive if uppercase letters
vim.opt.wrapscan = true -- Wrap around when searching

-- ============================================================================
-- UI & STATUS LINE
-- ============================================================================
vim.opt.showcmd = true -- Show partial commands in status line
vim.opt.showmode = true -- Show current mode
vim.opt.cmdheight = 1 -- Command line height
vim.opt.laststatus = 3 -- Global status line

-- ============================================================================
-- INDENTATION & TABS
-- ============================================================================
vim.opt.tabstop = 4 -- Number of spaces for a tab
vim.opt.shiftwidth = 4 -- Number of spaces for an indent
vim.opt.softtabstop = 4 -- Number of spaces for a tab in insert mode
vim.opt.expandtab = true -- Use spaces instead of tabs

-- ============================================================================
-- WHITESPACE VISIBILITY (Optional)
-- ============================================================================
-- vim.opt.list = true -- Show whitespace characters
-- vim.opt.listchars = "tab:▸\\ ,eol:¬,trail:·" -- Show tabs, EOL, and trailing spaces
