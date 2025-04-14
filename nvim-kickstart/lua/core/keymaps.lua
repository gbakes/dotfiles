-- Keymaps for better default experience

vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "yy", "Y")

-- General QOL Improvements

keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Centers screen after moving down" })
keymap.set("n", "<C-i>", "<C-d>zz", { desc = "Centers screen after moving down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Centers screen after moving up" })

keymap.set("n", "]m", "]mzz", { desc = "Centers screen after navigating function down" })

keymap.set("n", "d", '"dd', { noremap = true, desc = "delete and send text to special delete register" })
keymap.set("n", "dd", '"ddd', { noremap = true, desc = "delete line and send text to special delete register" })
keymap.set("v", "d", '"dd', { noremap = true, desc = "visual mode, delete and send text to special delete register" })
keymap.set("n", "x", '"_x', { noremap = true, desc = "" })

keymap.set("v", "<", "<gv", { noremap = true, desc = "" })
keymap.set("v", ">", ">gv", { noremap = true, desc = "" })

-- Move code blocks in visual mode
-- keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected line down
-- keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected line up

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- search and replace

-- increment/decrement numbers
keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>_", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

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

-- comments

keymap.set("n", "<leader>/", "<leader>gcc", { desc = "Toggle comment line" })

-- LazyGit

keymap.set("n", "<leader>lg", function()
	require("snacks").lazygit()
end, { desc = "LazyGit" })
keymap.set("n", "<leader>gl", function()
	require("snacks").lazygit.log()
end, { desc = "Git Log" })

keymap.set("n", "<leader>gbr", function()
	require("snacks").picker.git_branches({ layout = "select" })
end, { desc = "Pick and Switch Git Branches" })

-- Sessions

keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })             -- restore last workspace session for current directory
keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

-- substitute

-- keymap.set("n", "ls", substitute.operator, { desc = "Substitute with motion" })
-- keymap.set("n", "lss", substitute.line, { desc = "Substitute line" })
-- keymap.set("n", "LS", substitute.eol, { desc = "Substitute to end of line" })
-- keymap.set("x", "ls", substitute.visual, { desc = "Substitute in visual mode" })

-- LSP
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
--

vim.api.nvim_set_keymap("n", "<leader>db", ":DB<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
-- -- Set leader key
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '
--
-- -- For conciseness
-- local opts = { noremap = true, silent = true }
--
-- -- Disable the spacebar key's default behavior in Normal and Visual modes
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
--
-- -- Allow moving the cursor through wrapped lines with j, k
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--
-- -- clear highlights
-- vim.keymap.set('n', '<Esc>', ':noh<CR>', opts)
--
-- -- save file
-- vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)
--
-- -- save file without auto-formatting
-- vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)
--
-- -- quit file
-- vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)
--
-- -- delete single character without copying into register
-- vim.keymap.set('n', 'x', '"_x', opts)
--
-- -- Vertical scroll and center
-- vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
--
-- -- Find and center
-- vim.keymap.set('n', 'n', 'nzzzv')
-- vim.keymap.set('n', 'N', 'Nzzzv')
--
-- -- Resize with arrows
-- vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
-- vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
-- vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
-- vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)
--
-- -- Buffers
-- vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
-- vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
-- vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts)   -- close buffer
-- vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer
--
-- -- Increment/decrement numbers
-- vim.keymap.set('n', '<leader>+', '<C-a>', opts) -- increment
-- vim.keymap.set('n', '<leader>-', '<C-x>', opts) -- decrement
--
-- -- Window management
-- vim.keymap.set('n', '<leader>v', '<C-w>v', opts)      -- split window vertically
-- vim.keymap.set('n', '<leader>h', '<C-w>s', opts)      -- split window horizontally
-- vim.keymap.set('n', '<leader>se', '<C-w>=', opts)     -- make split windows equal width & height
-- vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window
--
-- -- Navigate between splits
-- vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
-- vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
-- vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
-- vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)
--
-- -- Tabs
-- vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts)   -- open new tab
-- vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
-- vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts)     --  go to next tab
-- vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts)     --  go to previous tab
--
-- -- Toggle line wrapping
-- vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)
--
-- -- Press jk fast to exit insert mode
-- vim.keymap.set('i', 'jk', '<ESC>', opts)
-- vim.keymap.set('i', 'kj', '<ESC>', opts)
--
-- -- Stay in indent mode
-- vim.keymap.set('v', '<', '<gv', opts)
-- vim.keymap.set('v', '>', '>gv', opts)
--
-- -- Move text up and down
-- vim.keymap.set('v', '<A-j>', ':m .+1<CR>==', opts)
-- vim.keymap.set('v', '<A-k>', ':m .-2<CR>==', opts)
--
-- -- Keep last yanked when pasting
-- vim.keymap.set('v', 'p', '"_dP', opts)
--
-- -- Replace word under cursor
-- vim.keymap.set('n', '<leader>j', '*``cgn', opts)
--
-- -- Explicitly yank to system clipboard (highlighted and entire row)
-- vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
-- vim.keymap.set('n', '<leader>Y', [["+Y]])
--
-- -- Toggle diagnostics
-- local diagnostics_active = true
--
-- vim.keymap.set('n', '<leader>do', function()
--   diagnostics_active = not diagnostics_active
--
--   if diagnostics_active then
--     vim.diagnostic.enable(0)
--   else
--     vim.diagnostic.disable(0)
--   end
-- end)
--
-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
--
-- -- Save and load session
-- vim.keymap.set('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })
