-- Highlight customizations
-- This file contains custom highlight group definitions for better UI appearance

-- ============================================================================
-- CURSOR LINE & LINE NUMBER COLORS
-- ============================================================================
-- Fix cursor line and selection colors for better visibility
vim.cmd([[
  highlight CursorLine guibg=#333333 gui=NONE
  highlight CursorLineNr guibg=#333333 guifg=#ffff00 gui=bold
]])

-- ============================================================================
-- VISUAL SELECTION COLOR
-- ============================================================================
-- Uncomment below if you want to customize visual selection colors
-- vim.cmd([[
--   highlight Visual guibg=#555555 guifg=NONE
--   highlight VisualNOS guibg=#555555 guifg=NONE
-- ]])

-- ============================================================================
-- SEARCH HIGHLIGHT COLORS
-- ============================================================================
-- Uncomment below if you want to customize search highlight colors
-- vim.cmd([[
--   highlight Search guibg=#ffff00 guifg=#000000
--   highlight IncSearch guibg=#ff6600 guifg=#000000
-- ]])

