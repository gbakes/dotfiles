-- Global keymaps only. Plugin-specific keymaps live in their plugin files.
local keymap = vim.keymap

-- Insert mode escape
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode" })

-- Wrap-aware movement
keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Centered navigation
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Clear highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Delete to special register (preserves yank clipboard)
keymap.set("n", "d", '"dd', { noremap = true, desc = "Delete to special register" })
keymap.set("v", "d", '"dd', { noremap = true, desc = "Visual delete to special register" })
keymap.set("n", "dd", '"ddd', { noremap = true, desc = "Delete line to special register" })
keymap.set("v", "dd", '"ddd', { noremap = true, desc = "Delete line to special register" })
keymap.set("n", "x", '"_x', { noremap = true, desc = "Delete char (no copy)" })
keymap.set("n", "X", '"dX', { noremap = true })
keymap.set("n", "c", '"dc', { noremap = true })
keymap.set("v", "c", '"dc', { noremap = true })
keymap.set("n", "cc", '"dcc', { noremap = true })
keymap.set("n", "C", '"dC', { noremap = true })
keymap.set("n", "s", '"ds', { noremap = true })
keymap.set("v", "s", '"ds', { noremap = true })
keymap.set("n", "S", '"dS', { noremap = true })

-- System clipboard
keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })
keymap.set("n", "<leader>yy", '"+Y', { desc = "Yank line to clipboard" })
keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from clipboard" })

-- Visual mode: move selection and indent
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap.set("v", "<", "<gv", { noremap = true, desc = "Indent left" })
keymap.set("v", ">", ">gv", { noremap = true, desc = "Indent right" })

-- Join lines keeping cursor position
keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })

-- Increment / decrement numbers
keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>_", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equal splits" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window resize
keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Buffer navigation
keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Source current file
keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source current file" })

-- Copy full file path to clipboard
keymap.set("n", "<leader>pa", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end, { desc = "Copy full file path" })

-- Diagnostics toggle
keymap.set("n", "<leader>tt", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
keymap.set("n", "<leader>ti", function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle inline diagnostics" })
keymap.set("n", "<leader>q", function()
  vim.diagnostic.setloclist({ open = true })
end, { desc = "Diagnostic list" })
keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Floating terminal (FloatingTerminal defined in config/terminal.lua)
keymap.set("n", "<leader>t", function()
  FloatingTerminal()
end, { noremap = true, silent = true, desc = "Toggle floating terminal" })
