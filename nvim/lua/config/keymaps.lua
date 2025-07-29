-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local keymap = vim.keymap

-- Exit insert mode with jk or kj
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- General QOL improvements
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Centers screen after moving down" })
keymap.set("n", "<C-i>", "<C-d>zz", { desc = "Centers screen after moving down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Centers screen after moving up" })

-- Centered search
keymap.set("n", "n", "nzzzv", { desc = "Next search result centered" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result centered" })

-- Better delete (sends to special register instead of clipboard)
keymap.set("n", "d", '"dd', { noremap = true, desc = "Delete to special register" })
keymap.set("n", "dd", '"ddd', { noremap = true, desc = "Delete line to special register" })
keymap.set("v", "d", '"dd', { noremap = true, desc = "Visual delete to special register" })
keymap.set("n", "x", '"_x', { noremap = true, desc = "Delete char without copying" })

-- Stay in indent mode
keymap.set("v", "<", "<gv", { noremap = true, desc = "Indent left and reselect" })
keymap.set("v", ">", ">gv", { noremap = true, desc = "Indent right and reselect" })

-- Move visual selection up/down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Increment/decrement numbers
keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>_", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Harpoon

keymap.set("n", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = "Show Harpoon menu" })
keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "Mark file with harpoon" })
keymap.set("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = "Go to next harpoon mark" })
keymap.set("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_previous()<cr>", { desc = "Go to previous mark" })

keymap.set("n", "<leader>ee", function()
  require("snacks").explorer()
end, { desc = "Open Snacks Explorer" })

keymap.set("n", "<leader>rN", function()
  require("snacks").rename.rename_file()
end, { desc = "Rename Current File" })

-- Snacks Picker

keymap.set("n", "<leader>ff", function()
  require("snacks").picker.files()
end, { desc = "Find Files (Snacks Picker)" })

keymap.set("n", "<leader>fc", function()
  require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })
keymap.set("n", "<leader>fs", function()
  require("snacks").picker.grep()
end, { desc = "Grep word" })
keymap.set("n", "<leader>fw", function()
  require("snacks").picker.grep_word()
end, { desc = "Search Visual selection or Word" })
keymap.set("n", "<leader>fk", function()
  require("snacks").picker.keymaps({ layout = "ivy" })
end, { desc = "Search Keymaps (Snacks Picker)" })

-- Toggle LSP diagnostics
keymap.set("n", "<leader>tt", function()
  local diagnostics_active = vim.diagnostic.is_enabled()
  if diagnostics_active then
    vim.diagnostic.enable(false)
  else
    vim.diagnostic.enable()
  end
end, { desc = "Toggle LSP diagnostics" })

-- Toggle inline diagnostics
keymap.set("n", "<leader>ti", function()
  local current_value = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = not current_value,
  })
end, { desc = "Toggle inline diagnostics" })

-- Source current file
keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source current file" })

-- System clipboard yanking (in addition to clipboard option)
keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
keymap.set("n", "<leader>yy", '"+Y', { desc = "Yank line to system clipboard" })

-- System clipboard pasting
keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

-- Obsidian keymaps
keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create new Obsidian note" })
keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open note in Obsidian app" })
keymap.set("n", "<leader>os", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick switch between notes" })
keymap.set("n", "<leader>of", "<cmd>ObsidianSearch<CR>", { desc = "Search notes" })
keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert template" })
keymap.set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "Open today's daily note" })
keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<CR>", { desc = "Open yesterday's daily note" })
keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<CR>", { desc = "Switch workspace" })
keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show backlinks" })
keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show links in current note" })
keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Rename note" })
keymap.set("v", "<leader>ol", "<cmd>ObsidianLink<CR>", { desc = "Create link from selection" })
keymap.set("v", "<leader>oL", "<cmd>ObsidianLinkNew<CR>", { desc = "Create new note from selection" })
keymap.set("n", "<leader>op", "<cmd>ObsidianPasteImg<CR>", { desc = "Paste image from clipboard" })
keymap.set("n", "<leader>oT", "<cmd>ObsidianTags<CR>", { desc = "Search by tags" })

-- Spectre keymaps
keymap.set("n", "<leader>sr", function() require("spectre").open() end, { desc = "Replace in files (Spectre)" })
keymap.set("n", "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, { desc = "Replace word (Spectre)" })
keymap.set("n", "<leader>sf", function() require("spectre").open_file_search({ select_word = true }) end, { desc = "Replace in current file (Spectre)" })
